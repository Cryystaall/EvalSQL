-- Procédure 1

CREATE PROCEDURE SEED_DATA(NB_PLAYERS INT, PARTY_ID INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    
    WHILE i <= NB_PLAYERS DO
        -- Crée un tour pour chaque joueur (en respectant max_turns)
        INSERT INTO turns (id_party, start_time, end_time) 
        VALUES (PARTY_ID, NOW(), NOW());
        
        SET i = i + 1;
    END WHILE;
END;


-- Procédure 2

CREATE PROCEDURE COMPLETE_TOUR(TOUR_ID INT, PARTY_ID INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE player_id INT;
    DECLARE cur CURSOR FOR 
        SELECT id_player 
        FROM players_in_parties 
        WHERE id_party = PARTY_ID AND is_alive = 'yes';
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO player_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Applique les déplacements du joueur pour ce tour
        UPDATE players_play 
        SET action = 'MOVE' 
        WHERE id_turn = TOUR_ID AND id_player = player_id;
        
        -- Résoudre les conflits s'il y en a
        -- Exemple : vérification et résolution des conflits (ajoutez votre logique ici)
        
    END LOOP;
    
    CLOSE cur;
END;


-- Procédure 3

CREATE PROCEDURE USERNAME_TO_LOWER()
BEGIN
    UPDATE players 
    SET pseudo = LOWER(pseudo);
END;
