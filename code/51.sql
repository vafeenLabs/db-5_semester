SELECT
    name
FROM
    (
        SELECT
            S.name,
            C.numGuns,
            C.displacement
        FROM
            Classes C
            JOIN Ships S ON C.class = S.class
        UNION
        SELECT
            O.ship AS name,
            C.numGuns,
            C.displacement
        FROM
            Classes C
            JOIN Outcomes O ON C.class = O.ship
    ) T
WHERE
    (T.numGuns, T.displacement) IN (
        SELECT
            MAX(numGuns),
            displacement
        FROM
            (
                SELECT
                    C.numGuns,
                    C.displacement
                FROM
                    Classes C
                    JOIN Ships S ON C.class = S.class
                UNION
                SELECT
                    C.numGuns,
                    C.displacement
                FROM
                    Classes C
                    JOIN Outcomes O ON C.class = O.ship
            ) MaxT
        GROUP BY
            displacement
    )