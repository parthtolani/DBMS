CREATE TABLE player (
    player_id INTEGER PRIMARY KEY,
    name VARCHAR,
    weight INTEGER,
    height INTEGER,
    date_of_birth DATE,
    gender CHAR(1),
    country_code VARCHAR(3)
);

CREATE TABLE country (
    country_code VARCHAR(3) PRIMARY KEY,
    name VARCHAR,
    continent VARCHAR,
    timezone VARCHAR
);

CREATE TABLE edition (
    year INTEGER PRIMARY KEY,
    no_of_countries INTEGER
);

CREATE TABLE sponsored_by (
    year INTEGER,
    sponsor_name VARCHAR,
    sponsor_type VARCHAR,
    PRIMARY KEY (year, sponsor_name)
);

CREATE TABLE sponsors (
    sponsor_name VARCHAR PRIMARY KEY
);

CREATE TABLE sport (
    sport_name VARCHAR,
    category VARCHAR,
    PRIMARY KEY (sport_name, category)
);

CREATE TABLE venue (
venue_id INTEGER PRIMARY KEY,
    name VARCHAR,
    state VARCHAR,
    city VARCHAR,
    pincode INTEGER,
    capacity INTEGER
);

CREATE TABLE plays_sport (
    player_id INTEGER,
    sport_name VARCHAR,
    category VARCHAR,
    PRIMARY KEY (player_id, sport_name, category),
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (sport_name, category) REFERENCES sport(sport_name, category)
);

CREATE TABLE event (
    event_id INTEGER PRIMARY KEY,
    date DATE,
    time TIME,
    stage VARCHAR,
    venue_id INTEGER,
    sport_name VARCHAR,
    category VARCHAR,
    FOREIGN KEY (venue_id) REFERENCES venue(venue_id),
    FOREIGN KEY (sport_name, category) REFERENCES sport(sport_name, category)
);

CREATE TABLE plays_in (
    player_id INTEGER,
    event_id INTEGER,
    PRIMARY KEY (player_id, event_id),
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

CREATE TABLE ticket (
    ticket_no INTEGER PRIMARY KEY,
    price INTEGER,
    event_id INTEGER,
    FOREIGN KEY (event_id) REFERENCES event(event_id),
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    name VARCHAR
);

CREATE TABLE works_in (
    staff_id INTEGER,
    event_id INTEGER,
    PRIMARY KEY (staff_id, event_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

CREATE TABLE tech_staff (
    staff_id INTEGER PRIMARY KEY,
    specialization VARCHAR,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE management_staff (
    staff_id INTEGER PRIMARY KEY,
    designation VARCHAR,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE match_official (
    staff_id INTEGER PRIMARY KEY,
    experience_in_yrs INTEGER,
    matches_officiated INTEGER,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE streaming_channel (
    channel_name VARCHAR PRIMARY KEY,
    country_code VARCHAR(3),
    FOREIGN KEY (country_code) REFERENCES country(country_code)
);

CREATE TABLE languages (
    channel_name VARCHAR,
    lang_name VARCHAR,
    PRIMARY KEY (channel_name, lang_name),
    FOREIGN KEY (channel_name) REFERENCES streaming_channel(channel_name)
);

CREATE TABLE present_in (
    sport_name VARCHAR,
    category VARCHAR,
    year INTEGER,
    PRIMARY KEY (sport_name, category, year),
    FOREIGN KEY (sport_name, category) REFERENCES sport(sport_name, category),
    FOREIGN KEY (year) REFERENCES edition(year)
);

CREATE TABLE has_winner (
    sport_name VARCHAR,
    category VARCHAR,
    year INTEGER,
    player_id INTEGER,
    medal_type VARCHAR,
    PRIMARY KEY (sport_name, category, year, player_id),
    FOREIGN KEY (sport_name, category) REFERENCES sport(sport_name, category),
    FOREIGN KEY (year) REFERENCES edition(year),
    FOREIGN KEY (player_id) REFERENCES player(player_id)
);