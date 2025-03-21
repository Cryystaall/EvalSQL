DROP TABLE IF EXISTS parties;
DROP TABLE IF EXISTS players_play;
DROP TABLE IF EXISTS players_in_parties;
DROP TABLE IF EXISTS turns;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS roles;

CREATE TABLE parties (
    id_party INT IDENTITY PRIMARY KEY,
    title_party VARCHAR(255) NOT NULL,
    nb_tours_total INT NOT NULL, -- Nombre total de tours prévus
    winner_id INT NULL, -- Vainqueur de la partie
    max_turns INT NOT NULL, -- Nombre maximum de tours
    FOREIGN KEY (winner_id) REFERENCES players(id_player)
);

CREATE TABLE roles (
    id_role INT IDENTITY PRIMARY KEY,
    description_role VARCHAR(50) NOT NULL CHECK (description_role IN ('VILLAGER', 'WOLF'))
);

CREATE TABLE players (
    id_player INT IDENTITY PRIMARY KEY,
    pseudo VARCHAR(100) UNIQUE NOT NULL,
    date_inscription DATETIME DEFAULT GETDATE() -- Permet de suivre la première participation
);

CREATE TABLE players_in_parties (
    id_party INT NOT NULL,
    id_player INT NOT NULL,
    id_role INT NOT NULL,
    is_alive BIT DEFAULT 1, -- 1 = vivant, 0 = mort
    PRIMARY KEY (id_party, id_player),
    FOREIGN KEY (id_party) REFERENCES parties(id_party),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE turns (
    id_turn INT IDENTITY PRIMARY KEY,
    id_party INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    FOREIGN KEY (id_party) REFERENCES parties(id_party)
);

CREATE TABLE players_play (
    id_player INT NOT NULL,
    id_turn INT NOT NULL,
    action NVARCHAR(10) NOT NULL CHECK (action IN ('MOVE', 'SKIP')),
    start_time DATETIME NOT NULL,
    end_time DATETIME NULL,
    origin_col INT NOT NULL,
    origin_row INT NOT NULL,
    target_col INT NULL,
    target_row INT NULL,
    PRIMARY KEY (id_player, id_turn),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_turn) REFERENCES turns(id_turn)
);
