
-- Insertion des rôles
INSERT INTO roles (id_role, description_role) VALUES
                                                  (1, 'Loup'),
                                                  (2, 'Villageois');

-- Insertion des joueurs
INSERT INTO players (id_player, pseudo) VALUES
                                            (1, 'Alphawolf'),
                                            (2, 'BetaVillage'),
                                            (3, 'GammaHowl'),
                                            (4, 'DeltaFarmer'),
                                            (5, 'EpsilonHunter'),
                                            (6, 'ZetaSheep'),
                                            (7, 'EtaWolf'),
                                            (8, 'ThetaHealer');

-- Insertion des parties
INSERT INTO parties (id_party, title_party) VALUES
                                                (1, N'Forêt Mystérieuse'),
                                                (2, 'Village Maudit'),
                                                (3, 'Nuit Sanglante');

-- Insertion des joueurs dans les parties
-- Partie 1
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (1, 1, 1, 'true'),  -- Loup
                                                                            (1, 2, 2, 'true'),  -- Villageois
                                                                            (1, 3, 1, 'false'), -- Loup
                                                                            (1, 4, 2, 'false'), -- Villageois
                                                                            (1, 5, 2, 'true');  -- Villageois

-- Partie 2
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (2, 3, 1, 'true'),  -- Loup
                                                                            (2, 4, 2, 'false'), -- Villageois
                                                                            (2, 5, 2, 'true'),  -- Villageois
                                                                            (2, 6, 2, 'true'),  -- Villageois
                                                                            (2, 7, 1, 'false'); -- Loup

-- Partie 3
INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) VALUES
                                                                            (3, 1, 2, 'true'),  -- Villageois
                                                                            (3, 2, 2, 'true'),  -- Villageois
                                                                            (3, 6, 1, 'true'),  -- Loup
                                                                            (3, 7, 1, 'false'), -- Loup
                                                                            (3, 8, 2, 'false'); -- Villageois

-- Insertion des tours de jeu
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

-- Insertion des actions des joueurs
-- Partie 1, Tour 1
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_position_row, origin_position_col, target_position_row, target_position_col) VALUES
                                                                                                                                                                    (1, 1, '2023-10-01 20:01:00', '2023-10-01 20:02:30', 'move', '1', '1', '1', '2'),
                                                                                                                                                                    (2, 1, '2023-10-01 20:03:00', '2023-10-01 20:04:15', 'move', '5', '5', '4', '5'),
                                                                                                                                                                    (3, 1, '2023-10-01 20:05:00', '2023-10-01 20:06:20', 'attack', '3', '3', '4', '3'),
                                                                                                                                                                    (4, 1, '2023-10-01 20:07:00', '2023-10-01 20:08:10', 'defend', '4', '4', '4', '4'),
                                                                                                                                                                    (5, 1, '2023-10-01 20:09:00', '2023-10-01 20:10:45', 'move', '2', '2', '2', '3');

-- Partie 1, Tour 2 (quelques exemples supplémentaires)
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_position_row, origin_position_col, target_position_row, target_position_col) VALUES
                                                                                                                                                                    (1, 2, '2023-10-01 20:17:00', '2023-10-01 20:18:30', 'attack', '1', '2', '2', '3'),
                                                                                                                                                                    (2, 2, '2023-10-01 20:19:00', '2023-10-01 20:20:45', 'move', '4', '5', '3', '5'),
                                                                                                                                                                    (3, 2, '2023-10-01 20:21:00', '2023-10-01 20:22:10', 'move', '3', '3', '3', '4'),
                                                                                                                                                                    (5, 2, '2023-10-01 20:25:00', '2023-10-01 20:26:30', 'defend', '2', '3', '2', '3');

-- Partie 2, Tour 4 (quelques exemples)
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_position_row, origin_position_col, target_position_row, target_position_col) VALUES
                                                                                                                                                                    (3, 4, '2023-10-02 19:02:00', '2023-10-02 19:03:30', 'attack', '1', '1', '2', '1'),
                                                                                                                                                                    (4, 4, '2023-10-02 19:04:00', '2023-10-02 19:05:45', 'move', '3', '3', '3', '4'),
                                                                                                                                                                    (5, 4, '2023-10-02 19:06:00', '2023-10-02 19:07:10', 'defend', '5', '5', '5', '5'),
                                                                                                                                                                    (6, 4, '2023-10-02 19:08:00', '2023-10-02 19:09:30', 'move', '2', '2', '2', '3'),
                                                                                                                                                                    (7, 4, '2023-10-02 19:10:00', '2023-10-02 19:11:45', 'attack', '4', '4', '3', '3');

-- Partie 3, Tour 8 (quelques exemples)
INSERT INTO players_play (id_player, id_turn, start_time, end_time, action, origin_position_row, origin_position_col, target_position_row, target_position_col) VALUES
                                                                                                                                                                    (1, 8, '2023-10-03 21:22:00', '2023-10-03 21:23:15', 'move', '1', '1', '1', '2'),
                                                                                                                                                                    (2, 8, '2023-10-03 21:24:00', '2023-10-03 21:25:30', 'defend', '5', '5', '5', '5'),
                                                                                                                                                                    (6, 8, '2023-10-03 21:26:00', '2023-10-03 21:27:10', 'attack', '3', '3', '1', '2'),
                                                                                                                                                                    (8, 8, '2023-10-03 21:28:00', '2023-10-03 21:29:45', 'move', '2', '2', '2', '3');