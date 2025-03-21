DELIMITER $$

CREATE FUNCTION random_position(party_id INT, num_rows INT, num_cols INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE rand_row INT;
    DECLARE rand_col INT;
    DECLARE position_exists INT;

    -- Boucle jusqu'à trouver une position non utilisée
    REPEAT
        -- Générer une ligne et une colonne aléatoires
        SET rand_row = FLOOR(1 + (RAND() * num_rows));
        SET rand_col = FLOOR(1 + (RAND() * num_cols));

        -- Vérifier si la position est déjà utilisée dans la partie donnée
        SELECT COUNT(*)
        INTO position_exists
        FROM players_play
        WHERE id_party = party_id
        AND origin_position_row = rand_row
        AND origin_position_col = rand_col;

    UNTIL position_exists = 0 -- La position n'existe pas dans cette partie
    END REPEAT;

    -- Retourner la position sous forme de texte
    RETURN CONCAT(rand_row, ',', rand_col);
END$$

DELIMITER ;
