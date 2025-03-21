create table parties (
                         id_party int,
                         title_party varchar(20)
);

create table roles (
                       id_role int,
                       description_role varchar(255)
);

create table players (
                         id_player int,
                         pseudo varchar(20)
);

create table players_in_parties (
                                    id_party int,
                                    id_player int,
                                    id_role int,
                                    is_alive varchar(20)
);

create table turns (
                       id_turn int,
                       id_party int,
                       start_time datetime,
                       end_time datetime
);

create table players_play (
                              id_player           int,
                              id_turn             int,
                              start_time          datetime,
                              end_time            datetime,
                              action              varchar(10),
                              origin_position_col varchar(255),
                              origin_position_row varchar(255),
                              target_position_col varchar(255),
                              target_position_row varchar(255)
);