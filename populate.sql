
-- Insertion des joueurs (doit être fait avant parties à cause de la clé étrangère winner_id)
SET IDENTITY_INSERT players ON;
INSERT INTO players (id_player, pseudo) VALUES
                                            (1, 'Alphawolf'),
                                            (2, 'BetaVillage'),
                                            (3, 'GammaHowl'),
                                            (4, 'DeltaFarmer'),
                                            (5, 'EpsilonHunter'),
                                            (6, 'ZetaSheep'),
                                            (7, 'EtaWolf'),
                                            (8, 'ThetaHealer');
SET IDENTITY_INSERT players OFF;
-- Vérification
SELECT * FROM players;

-- Insertion des rôles
SET IDENTITY_INSERT roles ON;
INSERT INTO roles (id_role, description_role) VALUES
                                                  (1, 'WOLF'),
                                                  (2, 'VILLAGER');
SET IDENTITY_INSERT roles OFF;
-- Vérification
SELECT * FROM roles;

-- Insertion des parties
SET IDENTITY_INSERT parties ON;
INSERT INTO parties (id_party, title_party, nb_tours_total, winner_id, max_turns) VALUES
                                                                                      (1, N'Forêt Mystérieuse', 3, NULL, 5),
                                                                                      (2, 'Village Maudit', 2, NULL, 4),
                                                                                      (3, 'Nuit Sanglante', 4, NULL, 6);
SET IDENTITY_INSERT parties OFF;
-- Vérification
SELECT * FROM parties;

-- Insertion des joueurs dans les parties
-- Partie 1
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (1, 1, 1, 1),  -- Loup
                                                                            (1, 2, 2, 1),  -- Villageois
                                                                            (1, 3, 1, 0),  -- Loup
                                                                            (1, 4, 2, 0),  -- Villageois
                                                                            (1, 5, 2, 1);  -- Villageois
-- Partie 2
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (2, 3, 1, 1),  -- Loup
                                                                            (2, 4, 2, 0),  -- Villageois
                                                                            (2, 5, 2, 1),  -- Villageois
                                                                            (2, 6, 2, 1),  -- Villageois
                                                                            (2, 7, 1, 0);  -- Loup
-- Partie 3
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (3, 1, 2, 1),  -- Villageois
                                                                            (3, 2, 2, 1),  -- Villageois
                                                                            (3, 6, 1, 1),  -- Loup
                                                                            (3, 7, 1, 0),  -- Loup
                                                                            (3, 8, 2, 0);  -- Villageois
-- Vérification
SELECT * FROM players_in_parties;

-- Insertion des tours de jeu
SET IDENTITY_INSERT turns ON;
-- Partie 1
INSERT INTO turns (id_turn, id_party, start_time, end_time) VALUES
                                                                (1, 1, '2023-10-01 20:00:00', '2023-10-01 20:15:00'),
                                                                (2, 1, '2023-10-01 20:16:00', '2023-10-01 20:30:00'),
                                                                (3, 1, '2023-10-01 20:31:00', '2023-10-01 20:45:00');
-- Partie 2
INSERT INTO turns (id_turn, id_party, start_time, end_time) VALUES
                                                                (4, 2, '2023-10-02 19:00:00', '2023-10-02 19:20:00'),
                                                                (5, 2, '2023-10-02 19:21:00', '2023-10-02 19:40:00');
-- Partie 3
INSERT INTO turns (id_turn, id_party, start_time, end_time) VALUES
                                                                (6, 3, '2023-10-03 21:00:00', '2023-10-03 21:10:00'),
                                                                (7, 3, '2023-10-03 21:11:00', '2023-10-03 21:20:00'),
                                                                (8, 3, '2023-10-03 21:21:00', '2023-10-03 21:30:00'),
                                                                (9, 3, '2023-10-03 21:31:00', '2023-10-03 21:40:00');
SET IDENTITY_INSERT turns OFF;
-- Vérification
SELECT * FROM turns;

-- Insertion des actions des joueurs
-- Partie 1, Tour 1
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_row, origin_col, target_row, target_col) VALUES
                                                                                                                                (1, 1, '2023-10-01 20:01:00', '2023-10-01 20:02:30', 'MOVE', 1, 1, 1, 2),
                                                                                                                                (2, 1, '2023-10-01 20:03:00', '2023-10-01 20:04:15', 'MOVE', 5, 5, 4, 5),
                                                                                                                                (3, 1, '2023-10-01 20:05:00', '2023-10-01 20:06:20', 'MOVE', 3, 3, 4, 3),
                                                                                                                                (4, 1, '2023-10-01 20:07:00', '2023-10-01 20:08:10', 'SKIP', 4, 4, 4, 4),
                                                                                                                                (5, 1, '2023-10-01 20:09:00', '2023-10-01 20:10:45', 'MOVE', 2, 2, 2, 3);
-- Partie 1, Tour 2
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_row, origin_col, target_row, target_col) VALUES
                                                                                                                                (1, 2, '2023-10-01 20:17:00', '2023-10-01 20:18:30', 'MOVE', 1, 2, 2, 3),
                                                                                                                                (2, 2, '2023-10-01 20:19:00', '2023-10-01 20:20:45', 'MOVE', 4, 5, 3, 5),
                                                                                                                                (3, 2, '2023-10-01 20:21:00', '2023-10-01 20:22:10', 'MOVE', 3, 3, 3, 4),
                                                                                                                                (5, 2, '2023-10-01 20:25:00', '2023-10-01 20:26:30', 'SKIP', 2, 3, 2, 3);
-- Partie 2, Tour 4
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_row, origin_col, target_row, target_col) VALUES
                                                                                                                                (3, 4, '2023-10-02 19:02:00', '2023-10-02 19:03:30', 'MOVE', 1, 1, 2, 1),
                                                                                                                                (4, 4, '2023-10-02 19:04:00', '2023-10-02 19:05:45', 'MOVE', 3, 3, 3, 4),
                                                                                                                                (5, 4, '2023-10-02 19:06:00', '2023-10-02 19:07:10', 'SKIP', 5, 5, 5, 5),
                                                                                                                                (6, 4, '2023-10-02 19:08:00', '2023-10-02 19:09:30', 'MOVE', 2, 2, 2, 3),
                                                                                                                                (7, 4, '2023-10-02 19:10:00', '2023-10-02 19:11:45', 'MOVE', 4, 4, 3, 3);
-- Partie 3, Tour 8
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_row, origin_col, target_row, target_col) VALUES
                                                                                                                                (1, 8, '2023-10-03 21:22:00', '2023-10-03 21:23:15', 'MOVE', 1, 1, 1, 2),
                                                                                                                                (2, 8, '2023-10-03 21:24:00', '2023-10-03 21:25:30', 'SKIP', 5, 5, 5, 5),
                                                                                                                                (6, 8, '2023-10-03 21:26:00', '2023-10-03 21:27:10', 'MOVE', 3, 3, 1, 2),
                                                                                                                                (8, 8, '2023-10-03 21:28:00', '2023-10-03 21:29:45', 'MOVE', 2, 2, 2, 3);
-- Vérification
SELECT * FROM players_play;