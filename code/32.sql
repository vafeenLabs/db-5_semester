SELECT
    country,
    ROUND(AVG((bore * bore * bore) / 2), 2)
FROM
    (
        SELECT
            country,
            class,
            bore,
            name
        FROM
            classes
            LEFT JOIN ships using(class)
        UNION
        ALL
        SELECT
            DISTINCT country,
            class,
            bore,
            ship
        FROM
            classes
            LEFT JOIN outcomes ON classes.class = outcomes.ship
        WHERE
            ship = class
            AND ship NOT IN (
                SELECT
                    name
                FROM
                    ships
            )
    ) a
WHERE
    name IS NOT NULL
GROUP BY
    country;