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



