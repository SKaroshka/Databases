SELECT h.*
FROM heroes h
JOIN races r ON h.race_id = r.id
WHERE LOWER(r.name) != 'human'
  AND CONVERT(h.name USING binary) LIKE '%a%'
  AND LOWER(h.class_role) IN ('tankman', 'tank', 'healer')
  AND h.id IN (
      SELECT hero_id
      FROM heroes_teams
      GROUP BY hero_id
      HAVING COUNT(DISTINCT team_id) >= 2
  )
ORDER BY h.id ASC
LIMIT 1;
