-- Trigger 1

CREATE TRIGGER after_turn_end
AFTER UPDATE ON turns
FOR EACH ROW
BEGIN
    IF NEW.end_time IS NOT NULL AND OLD.end_time IS NULL THEN
        CALL COMPLETE_TOUR(NEW.id_turn, NEW.id_party);
    END IF;
END;

-- Trigger 2

CREATE TRIGGER after_player_insert
AFTER INSERT ON players_in_parties
FOR EACH ROW
BEGIN
    CALL USERNAME_TO_LOWER();
END;
