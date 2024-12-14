WITH T AS (
SELECT C.class, S.name, O.result
FROM Classes C
JOIN Ships S ON C.class = S.class
LEFT JOIN Outcomes O ON S.name = O.ship
UNION
SELECT C.class, O.ship AS name, O.result
FROM Classes C
LEFT JOIN Outcomes O ON O.ship = C.class
WHERE O.result IS NOT NULL
)
SELECT class,
COUNT(CASE WHEN result = 'sunk' THEN 1 END) AS sunk
FROM T
GROUP BY class
HAVING COUNT(DISTINCT name) >= 3
AND COUNT(CASE WHEN result = 'sunk' THEN 1 END) > 0