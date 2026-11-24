SELECT heroes.name AS hero_name, teams.name AS team_name
FROM heroes
LEFT JOIN heroes_teams ON heroes.id = heroes_teams.hero_id
LEFT JOIN teams ON heroes_teams.team_id = teams.id;

 -- Усі здібності з героями, які володіють ними
SELECT heroes.name AS hero_name, powers.name AS power_name
FROM heroes
RIGHT JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
RIGHT JOIN powers ON heroes_powers.power_id = powers.id;

 -- Герої з їхніми командами та здібностями
SELECT heroes.name AS hero_name, powers.name AS power_name, teams.name AS team_name
FROM heroes
INNER JOIN heroes_powers ON heroes.id = heroes_powers.hero_id
INNER JOIN powers ON heroes_powers.power_id = powers.id
INNER JOIN heroes_teams ON heroes.id = heroes_teams.hero_id
INNER JOIN teams ON heroes_teams.team_id = teams.id;