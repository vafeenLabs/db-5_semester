SELECT
    DISTINCT battle
FROM
    Outcomes
    JOIN Ships ON Outcomes.ship = Ships.name
WHERE
    class = 'Kongo'