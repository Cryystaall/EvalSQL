-- Trigger 1
CREATE TRIGGER after_turn_end
    ON turns
    AFTER UPDATE
    AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
                 JOIN deleted d ON i.id_turn = d.id_turn
        WHERE i.end_time IS NOT NULL AND d.end_time IS NULL
    )
        BEGIN
            DECLARE @id_turn INT, @id_party INT;

            SELECT TOP 1 @id_turn = i.id_turn, @id_party = i.id_party
            FROM inserted i
                     JOIN deleted d ON i.id_turn = d.id_turn
            WHERE i.end_time IS NOT NULL AND d.end_time IS NULL;

            EXEC COMPLETE_TOUR @TOUR_ID = @id_turn, @PARTY_ID = @id_party;
        END
END;
GO

-- Trigger 2
CREATE TRIGGER after_player_insert
    ON players_in_parties
    AFTER INSERT
    AS
BEGIN
    EXEC USERNAME_TO_LOWER;
END;
GO