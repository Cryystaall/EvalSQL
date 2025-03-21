-- Procédure 1
CREATE PROCEDURE SEED_DATA
    @NB_PLAYERS INT,
    @PARTY_ID INT
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i <= @NB_PLAYERS
        BEGIN
            INSERT INTO turns (id_party, start_time, end_time)
            VALUES (@PARTY_ID, GETDATE(), GETDATE());

            SET @i = @i + 1;
        END;
END;
GO

-- Procédure 2
CREATE PROCEDURE COMPLETE_TOUR
    @TOUR_ID INT,
    @PARTY_ID INT
AS
BEGIN
    DECLARE @player_id INT;

    DECLARE player_cursor CURSOR FOR
        SELECT id_player
        FROM players_in_parties
        WHERE id_party = @PARTY_ID AND is_alive = 1;

    OPEN player_cursor;

    FETCH NEXT FROM player_cursor INTO @player_id;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            UPDATE players_play
            SET action = 'MOVE'
            WHERE id_turn = @TOUR_ID AND id_player = @player_id;

            FETCH NEXT FROM player_cursor INTO @player_id;
        END;

    CLOSE player_cursor;
    DEALLOCATE player_cursor;
END;
GO

-- Procédure 3
CREATE PROCEDURE USERNAME_TO_LOWER
AS
BEGIN
    UPDATE players
    SET pseudo = LOWER(pseudo)
    WHERE pseudo <> LOWER(pseudo);
END;
GO