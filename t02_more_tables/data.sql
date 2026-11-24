INSERT IGNORE INTO powers (name, type)
VALUES
    ('bloody fist', 'attack'),
    ('iron shield', 'defense'),
    ('lightning strike', 'attack'),
    ('energy barrier', 'defense'),
    ('telekinesis', 'attack');

INSERT IGNORE INTO races (name)
VALUES
    ('Human'),
    ('Kree'),
    ('Asgardian'),
    ('Mutant');

INSERT IGNORE INTO teams (name)
VALUES
    ('Avengers'),
    ('Hydra'),
    ('Guardians of the Galaxy'),
    ('X-Men');

SET @h1 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 0);
SET @h2 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 1);
SET @h3 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 2);
SET @h4 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 3);
SET @h5 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 4);
SET @h6 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 5);
SET @h7 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 6);
SET @h8 = (SELECT id FROM heroes ORDER BY id LIMIT 1 OFFSET 7);

 -- Раси героям
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Human') WHERE id = @h1;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Human') WHERE id = @h2;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Kree') WHERE id = @h3;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Asgardian') WHERE id = @h4;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Kree') WHERE id = @h5;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Kree') WHERE id = @h6;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Mutant') WHERE id = @h7;
UPDATE heroes SET race_id = (SELECT id FROM races WHERE name = 'Human') WHERE id = @h8;

 -- Призначення здібностей героям
INSERT IGNORE INTO heroes_powers (hero_id, power_id, power_points)
SELECT @h1, (SELECT id FROM powers WHERE name = 'bloody fist'), 110 WHERE @h1 IS NOT NULL
UNION ALL
SELECT @h1, (SELECT id FROM powers WHERE name = 'energy barrier'), 150 WHERE @h1 IS NOT NULL
UNION ALL
SELECT @h2, (SELECT id FROM powers WHERE name = 'iron shield'), 200 WHERE @h2 IS NOT NULL
UNION ALL
SELECT @h2, (SELECT id FROM powers WHERE name = 'bloody fist'), 110 WHERE @h2 IS NOT NULL
UNION ALL
SELECT @h3, (SELECT id FROM powers WHERE name = 'lightning strike'), 250 WHERE @h3 IS NOT NULL
UNION ALL
SELECT @h4, (SELECT id FROM powers WHERE name = 'bloody fist'), 110 WHERE @h4 IS NOT NULL
UNION ALL
SELECT @h5, (SELECT id FROM powers WHERE name = 'energy barrier'), 180 WHERE @h5 IS NOT NULL
UNION ALL
SELECT @h6, (SELECT id FROM powers WHERE name = 'telekinesis'), 170 WHERE @h6 IS NOT NULL;

 -- Призначення команд
INSERT IGNORE INTO heroes_teams (hero_id, team_id)
SELECT @h1, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h1 IS NOT NULL
UNION ALL
SELECT @h2, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h2 IS NOT NULL
UNION ALL
SELECT @h3, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h3 IS NOT NULL
UNION ALL
SELECT @h4, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h4 IS NOT NULL
UNION ALL
SELECT @h4, (SELECT id FROM teams WHERE name = 'Hydra') WHERE @h4 IS NOT NULL
UNION ALL
SELECT @h5, (SELECT id FROM teams WHERE name = 'Hydra') WHERE @h5 IS NOT NULL
UNION ALL
SELECT @h5, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h5 IS NOT NULL
UNION ALL
SELECT @h6, (SELECT id FROM teams WHERE name = 'Guardians of the Galaxy') WHERE @h6 IS NOT NULL
UNION ALL
SELECT @h6, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h6 IS NOT NULL
UNION ALL
SELECT @h7, (SELECT id FROM teams WHERE name = 'X-Men') WHERE @h7 IS NOT NULL
UNION ALL
SELECT @h7, (SELECT id FROM teams WHERE name = 'Avengers') WHERE @h7 IS NOT NULL;