SELECT
    ROW_NUMBER() OVER(
        ORDER BY
            maker,
            sort
    ) AS num,
    CASE
        WHEN ROW_NUMBER() OVER (
            PARTITION BY maker
            ORDER BY
                sort
        ) = 1 THEN maker
        ELSE NULL
    END AS maker,
    type
FROM
    (
        SELECT
            maker,
            type,
            CASE
                WHEN type = 'PC' THEN 1
                WHEN TYPE = 'Laptop' THEN 2
                ELSE 3
            END AS sort
        FROM
            Product
        GROUP BY
            maker,
            type
    )
ORDER BY
    maker,
    sort