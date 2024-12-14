SELECT
    name
FROM
    Ships
    JOIN Classes ON Ships.class = Classes.class
WHERE
    bore = 16
UNION
SELECT
    ship
FROM
    Outcomes
    JOIN Classes ON Outcomes.ship = Classes.class
WHERE
    bore = 16