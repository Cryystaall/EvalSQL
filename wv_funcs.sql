CREATE FUNCTION random_position(@nb_rows INT, @nb_cols INT, @party_id INT)
    RETURNS TABLE
        AS
        RETURN
        (
        WITH used_positions AS (
            SELECT DISTINCT
                origin_position_row AS row_pos,
                origin_position_col AS col_pos
            FROM players_play pp
                     JOIN turns t ON pp.id_turn = t.id_turn
            WHERE t.id_party = @party_id
            UNION
            SELECT DISTINCT
                target_position_row,
                target_position_col
            FROM players_play pp
                     JOIN turns t ON pp.id_turn = t.id_turn
            WHERE t.id_party = @party_id
        ),
             all_positions AS (
                 SELECT
                     r.row_num AS row_pos,
                     c.col_num AS col_pos
                 FROM
                     (SELECT TOP (@nb_rows) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS row_num FROM master.dbo.spt_values) r
                         CROSS JOIN
                     (SELECT TOP (@nb_cols) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS col_num FROM master.dbo.spt_values) c
             )
        SELECT TOP 1
            CAST(row_pos AS VARCHAR(255)) AS position_row,
            CAST(col_pos AS VARCHAR(255)) AS position_col
        FROM all_positions
        WHERE NOT EXISTS (
            SELECT 1 FROM used_positions
            WHERE used_positions.row_pos = CAST(all_positions.row_pos AS VARCHAR(255))
              AND used_positions.col_pos = CAST(all_positions.col_pos AS VARCHAR(255))
        )
        );
GO

CREATE FUNCTION random_role(@party_id INT)
    RETURNS INT
AS
BEGIN
    DECLARE @wolf_id INT = 1;
    DECLARE @villager_id INT = 2;
    DECLARE @total_players INT;
    DECLARE @wolf_count INT;
    DECLARE @next_role INT;

    SELECT @total_players = COUNT(*)
    FROM players_in_parties
    WHERE id_party = @party_id;

    SELECT @wolf_count = COUNT(*)
    FROM players_in_parties
    WHERE id_party = @party_id AND id_role = @wolf_id;

    IF (@wolf_count < CEILING((@total_players + 1) / 3.0))
        SET @next_role = @wolf_id;
    ELSE
        SET @next_role = @villager_id;

    RETURN @next_role;
END;
GO

CREATE FUNCTION get_the_winner(@party_id INT)
    RETURNS TABLE
        AS
        RETURN
        (
        WITH player_stats AS (
            SELECT
                p.id_player,
                p.pseudo AS nom_joueur,
                CASE
                    WHEN r.id_role = 1 THEN 'Loup'
                    WHEN r.id_role = 2 THEN 'Villageois'
                    ELSE r.description_role
                    END AS role,
                pt.title_party AS nom_partie,
                COUNT(DISTINCT pp.id_turn) AS nb_tours_joues,
                (SELECT COUNT(*) FROM turns WHERE id_party = @party_id) AS nb_total_tours,
                AVG(DATEDIFF(SECOND, pp.start_time, pp.end_time)) AS temps_moyen_decision
            FROM players p
                     JOIN players_in_parties pip ON p.id_player = pip.id_player
                     JOIN roles r ON pip.id_role = r.id_role
                     JOIN parties pt ON pip.id_party = pt.id_party
                     JOIN players_play pp ON p.id_player = pp.id_player
                     JOIN turns t ON pp.id_turn = t.id_turn AND t.id_party = pt.id_party
            WHERE pip.id_party = @party_id
              AND pip.is_alive = 'true'
            GROUP BY p.id_player, p.pseudo, r.id_role, r.description_role, pt.title_party
        )
        SELECT * FROM player_stats
        );
GO