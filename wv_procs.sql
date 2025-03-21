-- Procédure 1
CREATE PROCEDURE SEED_DATA
    @NB_PLAYERS INT,
    @PARTY_ID INT
AS
BEGIN
    DECLARE @i INT = 1;

    WHILE @i <= @NB_PLAYERS
        BEGIN
            -- Crée un tour pour chaque joueur (en respectant max_turns)
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
    DECLARE @done INT = 0;
    DECLARE @player_id INT;

    -- Déclaration du curseur
    DECLARE player_cursor CURSOR FOR
        SELECT id_player
        FROM players_in_parties
        WHERE id_party = @PARTY_ID AND is_alive = 1;

    OPEN player_cursor;

    -- Récupération du premier enregistrement
    FETCH NEXT FROM player_cursor INTO @player_id;

    -- Boucle sur tous les joueurs
    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Applique les déplacements du joueur pour ce tour
            UPDATE players_play
            SET action = 'MOVE'
            WHERE id_turn = @TOUR_ID AND id_player = @player_id;

            -- Résoudre les conflits s'il y en a
            -- Exemple : vérification et résolution des conflits (ajoutez votre logique ici)

            -- Récupération de l'enregistrement suivant
            FETCH NEXT FROM player_cursor INTO @player_id;
        END;

    -- Fermeture et libération du curseur
    CLOSE player_cursor;
    DEALLOCATE player_cursor;
END;
GO

-- Procédure 3
CREATE PROCEDURE USERNAME_TO_LOWER
AS
BEGIN
    UPDATE players
    SET pseudo = LOWER(pseudo);
END;
GO