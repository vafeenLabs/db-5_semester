WITH T AS (
    SELECT
        C.class,
        S.name AS ship_name,
        O.result
    FROM
        Classes C
        JOIN Ships S ON C.class = S.class
        JOIN Outcomes O ON S.name = O.ship
    UNION
    SELECT
        C.class,
        O.ship AS ship_name,
        O.result
    FROM
        Classes C
        JOIN Outcomes O ON O.ship = C.class
)
SELECT
    C.class,
    COUNT(
        CASE
            WHEN T.result = 'sunk' THEN 1
        END
    ) AS sunk_count
FROM
    Classes C
    LEFT JOIN T ON C.class = T.class
GROUP BY
    C.class;