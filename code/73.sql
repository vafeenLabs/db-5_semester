SELECT
    c.country,
    b.name battle
FROM
    Classes c
    CROSS JOIN Battles b
MINUS
SELECT
    c.country,
    o.battle
FROM
    (
        SELECT
            class,
            name ship_name
        FROM
            SHIPS
        UNION
        SELECT
            ship,
            ship
        FROM
            Outcomes
    ) t
    JOIN Classes c ON t.class = c.class
    JOIN Outcomes o ON o.ship = t.ship_name