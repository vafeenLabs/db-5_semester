WITH AL AS (
    SELECT
        COUNT(name) AS CS,
        country
    FROM
        (
            SELECT
                name,
                country
            FROM
                Classes
                INNER JOIN Ships ON Classes.class = Ships.class
            UNION
            SELECT
                ship,
                country
            FROM
                Classes
                INNER JOIN Outcomes ON Outcomes.ship = Classes.class
        )
    GROUP BY
        country
),
SU AS (
    SELECT
        COUNT(name) AS CS,
        country
    FROM
        (
            SELECT
                name,
                country
            FROM
                Classes
                INNER JOIN Ships ON Ships.class = Classes.class
            WHERE
                name IN (
                    SELECT
                        DISTINCT ship
                    FROM
                        Outcomes
                    WHERE
                        result = 'sunk'
                )
            UNION
            SELECT
                ship,
                country
            FROM
                Classes
                INNER JOIN Outcomes ON Outcomes.ship = Classes.class
            WHERE
                ship IN (
                    SELECT
                        DISTINCT ship
                    FROM
                        Outcomes
                    WHERE
                        result LIKE 'sunk'
                )
        )
    GROUP BY
        country
)
SELECT
    AL.country
FROM
    AL
    INNER JOIN SU ON AL.CS = SU.CS
    and AL.country = SU.country