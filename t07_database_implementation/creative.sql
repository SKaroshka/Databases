CREATE DATABASE IF NOT EXISTS creative_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE creative_db;

 -- Видалення старих таблиць
DROP TABLE IF EXISTS CAPTURES;
DROP TABLE IF EXISTS CRIMES;
DROP TABLE IF EXISTS HEROES;
DROP TABLE IF EXISTS VILLAINS;

 -- Злодії
CREATE TABLE VILLAINS (
    id INT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(100) NULL,
    alias VARCHAR(100) NOT NULL,
    threat_level ENUM('Low', 'Moderate', 'High', 'Omega') NOT NULL,
    origin VARCHAR(100) NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_villains_alias (alias),
    INDEX idx_villains_threat_level (threat_level)
);

 -- Герої
CREATE TABLE HEROES (
    id INT NOT NULL AUTO_INCREMENT,
    real_name VARCHAR(100) NOT NULL,
    hero_alias VARCHAR(100) NOT NULL,
    clearance_level TINYINT NOT NULL,
    active_status ENUM('Active', 'Retired', 'MIA', 'Deceased') NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_heroes_hero_alias (hero_alias),
    INDEX idx_heroes_active_status (active_status)
);

 -- Злочини
CREATE TABLE CRIMES (
    id INT NOT NULL AUTO_INCREMENT,
    villain_id INT NOT NULL,
    crime_title VARCHAR(150) NOT NULL,
    crime_type ENUM('Espionage', 'Terrorism', 'Artifact Theft', 'Mass Destruction', 'Cybercrime', 'Other') NOT NULL,
    description TEXT NULL,
    incident_date DATE NOT NULL,
    location VARCHAR(150) NOT NULL,
    PRIMARY KEY (id),
    INDEX idx_crimes_villain_id (villain_id),
    INDEX idx_crimes_crime_type (crime_type),
    INDEX idx_crimes_incident_date (incident_date),
    CONSTRAINT fk_crimes_villain
        FOREIGN KEY (villain_id) REFERENCES VILLAINS(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

 -- Затримання
CREATE TABLE CAPTURES (
    id INT NOT NULL AUTO_INCREMENT,
    villain_id INT NOT NULL,
    hero_id INT NOT NULL,
    capture_date DATETIME NOT NULL,
    capture_location VARCHAR(150) NOT NULL,
    villain_status ENUM('Imprisoned', 'Under Interrogation', 'Transferred to The Raft', 'Escaped', 'Neutralized') NOT NULL,
    damage_severity ENUM('None', 'Minor', 'Moderate', 'Severe', 'Catastrophic') NOT NULL,
    battle_damage_report TEXT NULL,
    PRIMARY KEY (id),
    INDEX idx_captures_villain_id (villain_id),
    INDEX idx_captures_hero_id (hero_id),
    INDEX idx_captures_capture_date (capture_date),
    INDEX idx_captures_villain_status (villain_status),
    CONSTRAINT fk_captures_villain
        FOREIGN KEY (villain_id) REFERENCES VILLAINS(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_captures_hero
        FOREIGN KEY (hero_id) REFERENCES HEROES(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

 -- Дані 
INSERT INTO VILLAINS (full_name, alias, threat_level, origin) 
VALUES
    ('Loki Laufeyson', 'God of Mischief', 'Omega', 'Jotunheim'),
    ('Norman Osborn', 'Green Goblin', 'High', 'New York, USA'),
    ('Otto Octavius', 'Doctor Octopus', 'High', 'Schenectady, USA'),
    ('Quentin Beck', 'Mysterio', 'Moderate', 'New York, USA'),
    ('Adrian Toomes', 'Vulture', 'Moderate', 'New York, USA'),
    ('Helmut Zemo', 'Baron Zemo', 'High', 'Sokovia'),
    ('Brock Rumlow', 'Crossbones', 'Moderate', 'New York, USA'),
    ('Emil Blonsky', 'Abomination', 'Omega', 'Zagreb, Croatia'),
    (NULL, 'Taskmaster', 'High', NULL),
    ('Mac Gargan', 'Scorpion', 'Low', 'New York, USA');

INSERT INTO HEROES (real_name, hero_alias, clearance_level, active_status) 
VALUES
    ('Peter Parker', 'Spider-Man', 6, 'Active'),
    ('Tony Stark', 'Iron Man', 10, 'Deceased'),
    ('Steve Rogers', 'Captain America', 10, 'Retired'),
    ('Natasha Romanoff', 'Black Widow', 9, 'Deceased'),
    ('Clint Barton', 'Hawkeye', 8, 'Retired'),
    ('Sam Wilson', 'Captain America (Wilson)', 9, 'Active'),
    ('Stephen Strange', 'Doctor Strange', 9, 'Active'),
    ('Bruce Banner', 'Hulk', 9, 'Active'),
    ('Carol Danvers', 'Captain Marvel', 10, 'Active'),
    ('Wanda Maximoff', 'Scarlet Witch', 8, 'MIA');

INSERT INTO CRIMES (villain_id, crime_title, crime_type, description, incident_date, location) 
VALUES
    (1, 'Tesseract Vault Breach', 'Artifact Theft', 'Unauthorized extraction of the Tesseract from underground S.H.I.E.L.D. research facility.', '2024-05-04', 'Mojave Desert, USA'),
    (2, 'Oscorp Glider Strike on Queensboro', 'Terrorism', 'Aerial attack using experimental pumpkin bombs and armored glider.', '2024-06-18', 'New York, USA'),
    (3, 'Fusion Reactor Overload Incident', 'Mass Destruction', 'Unstable tritium-powered fusion experiment threatening East River waterfront.', '2024-07-11', 'Manhattan, New York'),
    (4, 'B.A.R.F. Drone Illusion Attack', 'Cybercrime', 'Hijacking of satellite defense network to project city-wide holographic threats.', '2024-08-22', 'London, UK'),
    (5, 'Chitauri Salvage Convoy Heist', 'Artifact Theft', 'Mid-air interception of Damage Control transport plane carrying alien tech.', '2024-09-03', 'New Jersey, USA'),
    (6, 'UN Vienna Summit Bombing', 'Terrorism', 'Covert infiltration and detonation targeting international delegation.', '2024-10-14', 'Vienna, Austria'),
    (7, 'IFID Biological Sample Theft', 'Espionage', 'Armed raid on infectious disease institute to steal viral weapon prototype.', '2024-11-02', 'Lagos, Nigeria'),
    (8, 'Harlem Military Rampage', 'Mass Destruction', 'Engagement with military armored units causing severe urban infrastructure damage.', '2024-12-09', 'Harlem, New York'),
    (9, 'Red Room Encrypted Server Breach', 'Espionage', 'Extraction of classified tactical dossiers on active field operatives.', '2025-01-19', 'Budapest, Hungary'),
    (10, 'Staten Island Ferry Arms Deal', 'Other', NULL, '2025-02-27', 'New York Harbor, USA');

INSERT INTO CAPTURES (villain_id, hero_id, capture_date, capture_location, villain_status, damage_severity, battle_damage_report) 
VALUES
    (1, 7, '2024-05-06 18:45:00', 'Stark Tower, New York', 'Transferred to The Raft', 'Catastrophic', 'Extensive structural damage across midtown Manhattan; dimensional portal closed.'),
    (2, 1, '2024-06-19 02:15:00', 'Statue of Liberty, New York', 'Imprisoned', 'Severe', 'Scaffolding collapsed; minor civilian injuries, zero fatalities.'),
    (3, 1, '2024-07-12 21:30:00', 'Hudson River Pier 14', 'Under Interrogation', 'Moderate', 'Warehouse roof collapsed; reactor safely submerged in river.'),
    (4, 1, '2024-08-23 15:10:00', 'Tower Bridge, London', 'Neutralized', 'Severe', 'Bridge roadway damaged by combat drones; holographic emitters destroyed.'),
    (5, 1, '2024-09-04 00:50:00', 'Coney Island Beach, New York', 'Imprisoned', 'Minor', 'Cargo plane crash-landed on empty shoreline; minimal property loss.'),
    (6, 6, '2024-10-16 11:20:00', 'Joint Counter-Terrorist Center, Berlin', 'Transferred to The Raft', 'None', 'Suspect apprehended without open combat.'),
    (7, 4, '2024-11-02 14:05:00', 'Lagos Market District', 'Neutralized', 'Severe', 'Adjacent commercial building facade destroyed during containment.'),
    (8, 8, '2024-12-10 01:40:00', '125th Street, Harlem', 'Transferred to The Raft', 'Catastrophic', 'Multiple city blocks damaged; emergency evacuation successful.'),
    (9, 4, '2025-01-21 19:00:00', 'Abandoned Airfield, Hungary', 'Escaped', 'Moderate', 'Target briefly detained before remote extraction team breached perimeter.'),
    (10, 1, '2025-02-27 16:35:00', 'Staten Island Ferry', 'Imprisoned', 'Minor', 'Ferry hull stabilized using synthetic webbing; passengers evacuated safely.');
