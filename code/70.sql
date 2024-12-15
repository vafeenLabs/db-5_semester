WITH BattleShips AS (
    SELECT
        b.name AS battle_name,
        c.country,
        COUNT(DISTINCT o.ship) AS ship_count
    FROM
        Battles b
        JOIN Outcomes o ON b.name = o.battle
        LEFT JOIN Ships s ON o.ship = s.name
        LEFT JOIN Classes c ON s.class = c.class
        OR c.class = o.ship
    WHERE
        c.country IS NOT NULL
    GROUP BY
        b.name,
        c.country
)
SELECT
    battle_name
FROM
    BattleShips
WHERE
    ship_count >= 3
GROUP BY
    battle_name