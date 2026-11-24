 -- Найсильніший герой (сума всіх навичок атаки та захисту; при рівній силі — менший айді)
SELECT h.id, h.name, COALESCE(SUM(hp.power_points), 0) AS power
FROM heroes h
LEFT JOIN heroes_powers hp ON h.id = hp.hero_id
GROUP BY h.id, h.name
ORDER BY power DESC, h.id ASC
LIMIT 1;

 -- Найслабший герой (найменша сума навичок захисту)
SELECT h.id, h.name, COALESCE(SUM(CASE WHEN p.type = 'defense' THEN hp.power_points ELSE 0 END), 0) AS defense
FROM heroes h
LEFT JOIN heroes_powers hp ON h.id = hp.hero_id
LEFT JOIN powers p ON hp.power_id = p.id
GROUP BY h.id, h.name
ORDER BY defense ASC, h.id ASC
LIMIT 1;

 -- Усі Месники, окрім подвійного агента, за спаданням загальної сили
SELECT h.id, h.name, COALESCE(SUM(hp.power_points), 0) AS power
FROM heroes h
LEFT JOIN heroes_powers hp ON h.id = hp.hero_id
WHERE h.id IN (
    SELECT ht.hero_id
    FROM heroes_teams ht
    JOIN teams t ON ht.team_id = t.id
    WHERE t.name = 'Avengers'
)
AND h.id NOT IN (
    SELECT hero_id
    FROM heroes_teams
    WHERE hero_id IS NOT NULL
    GROUP BY hero_id
    HAVING COUNT(DISTINCT team_id) > 1
)
GROUP BY h.id, h.name
ORDER BY power DESC, h.id ASC;

 -- Загальна сила команд Месники і Гідра, найсильніша команда — остання
SELECT t.name, COALESCE(SUM(hp.power_points), 0) AS power
FROM teams t
LEFT JOIN (
    SELECT DISTINCT hero_id, team_id
    FROM heroes_teams
) ht ON t.id = ht.team_id
LEFT JOIN heroes_powers hp ON ht.hero_id = hp.hero_id
WHERE t.name IN ('Avengers', 'Hydra')
GROUP BY t.id, t.name
ORDER BY power ASC, t.id ASC;
