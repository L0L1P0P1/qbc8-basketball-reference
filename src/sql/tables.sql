CREATE TABLE IF NOT EXISTS players ( 
	player_id VARCHAR(31) UNIQUE NOT NULL PRIMARY KEY, 
	player_name VARCHAR(255) NOT NULL,
	height_cm INT,
	weight_kg INT,
	retired TINYINT(1),
	experience TINYINT,
	birthplace VARCHAR(63),
	birthdate YEAR
);

CREATE TABLE IF NOT EXISTS team_year_mapping (
	team_year_id VARCHAR(8) UNIQUE NOT NULL PRIMARY KEY,
	team_id VARCHAR(3) NOT NULL,
	year YEAR NOT NULL
);

CREATE TABLE IF NOT EXISTS player_team_year (
	player_id VARCHAR(31),
	team_year_id VARCHAR(8),
	PRIMARY KEY (player_id, team_year_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
	FOREIGN KEY (team_year_id) REFERENCES team_year_mapping(team_year_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS player_position (
	player_id VARCHAR(31),
	position VARCHAR(31),
	PRIMARY KEY (player_id, position),
	FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS player_rank (
	rank INT NOT NULL,
	player_id VARCHAR(31),
	team_year_id VARCHAR(8),
	PRIMARY KEY (rank,player_id,team_year_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
	FOREIGN KEY (team_year_id) REFERENCES team_year_mapping(team_year_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mvp (
	player_id VARCHAR(31),
	team_year_id VARCHAR(8),
	PRIMARY KEY (player_id, team_year_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
	FOREIGN KEY (team_year_id) REFERENCES team_year_mapping(team_year_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS standings (
	standing TINYINT,
	team_year_id VARCHAR(8),
	PRIMARY KEY (standing, team_year_id),
	FOREIGN KEY (team_year_id) REFERENCES team_year_mapping(team_year_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS mvp_nominees (
	mvp_ranking TINYINT,
	player_id VARCHAR(31),
	team_year_id VARCHAR(8),
	PRIMARY KEY (mvp_ranking, player_id, team_year_id),
	FOREIGN KEY (player_id) REFERENCES players(player_id) ON DELETE CASCADE,
	FOREIGN KEY (team_year_id) REFERENCES team_year_mapping(team_year_id) ON DELETE CASCADE
);

