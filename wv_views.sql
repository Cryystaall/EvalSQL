-- Vue 1
CREATE VIEW ALL_PLAYERS AS
SELECT TOP 100 PERCENT
    p.pseudo AS nom_joueur,
    COUNT(DISTINCT pip.id_party) AS nombre_parties_jouees,
    COUNT(DISTINCT pp.id_turn) AS nombre_tours_joues,
    MIN(pp.start_time) AS premiere_participation,
    MAX(pp.end_time) AS derniere_action
FROM
    players p
        INNER JOIN players_in_parties pip ON p.id_player = pip.id_player
        INNER JOIN players_play pp ON p.id_player = pp.id_player
GROUP BY
    p.id_player, p.pseudo
ORDER BY
    nombre_parties_jouees DESC,
    premiere_participation,
    derniere_action,
    nom_joueur;
GO

-- Vue 2
CREATE VIEW ALL_PLAYERS_ELAPSED_GAME AS
SELECT TOP 100 PERCENT
    p.pseudo AS nom_joueur,
    pt.title_party AS nom_partie,
    (SELECT COUNT(*) FROM players_in_parties WHERE id_party = pt.id_party) AS nombre_participants,
    MIN(pp.start_time) AS premiere_action,
    MAX(pp.end_time) AS derniere_action,
    DATEDIFF(SECOND, MIN(pp.start_time), MAX(pp.end_time)) AS nb_secondes_passees
FROM
    players p
        INNER JOIN players_in_parties pip ON p.id_player = pip.id_player
        INNER JOIN parties pt ON pip.id_party = pt.id_party
        INNER JOIN turns t ON pt.id_party = t.id_party
        INNER JOIN players_play pp ON p.id_player = pp.id_player AND t.id_turn = pp.id_turn
GROUP BY
    p.id_player, p.pseudo, pt.id_party, pt.title_party
ORDER BY
    p.pseudo, pt.title_party;
GO

-- Vue 3
CREATE VIEW ALL_PLAYERS_ELAPSED_TOUR AS
SELECT
    p.pseudo AS nom_joueur,
    pa.title_party AS nom_partie,
    COUNT(pp.id_player) AS nombre_participants,
    MIN(pp.start_time) AS debut_partie_joueur,
    MAX(pp.end_time) AS fin_partie_joueur,
    DATEDIFF(SECOND, MIN(pp.start_time), MAX(pp.end_time)) AS temps_total_sec
FROM players_play pp
         JOIN players p ON pp.id_player = p.id_player
         JOIN turns t ON pp.id_turn = t.id_turn
         JOIN parties pa ON t.id_party = pa.id_party
GROUP BY p.pseudo, pa.title_party;
GO

-- Vue 4
CREATE VIEW ALL_PLAYERS_STATS AS
SELECT
    p.pseudo AS player_name,
    r.description_role AS role,
    pr.title_party AS party_name,
    COUNT(tp.id_turn) AS num_turns_played,
    (SELECT COUNT(*) FROM turns t WHERE t.id_party = pr.id_party) AS total_turns_in_party,
    IIF(pip.is_alive = 'true', 'Vainqueur', 'Perdant') AS winner,
    AVG(DATEDIFF(SECOND, pp.start_time, pp.end_time)) AS avg_decision_time
FROM
    players p
        JOIN
    players_in_parties pip ON p.id_player = pip.id_player
        JOIN
    parties pr ON pip.id_party = pr.id_party
        JOIN
    roles r ON pip.id_role = r.id_role
        JOIN
    players_play pp ON p.id_player = pp.id_player
        JOIN
    turns tp ON pp.id_turn = tp.id_turn AND tp.id_party = pr.id_party
GROUP BY
    p.pseudo, r.description_role, pr.title_party, pip.is_alive, pr.id_party;
GO