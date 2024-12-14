SELECT
    class
FROM
    Ships
WHERE
    name IN (
        SELECT
            ship
        FROM
            Outcomes
        WHERE
            result = 'sunk'
    )
UNION
SELECT
    ship
FROM
    Outcomes
WHERE
    ship IN(
        SELECT
            class
        FROM
            Classes
    )
    and result = 'sunk'