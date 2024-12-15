WITH max_prices AS (
    SELECT
        p.maker,
        MAX(
            CASE
                WHEN p.type = 'Laptop' THEN l.price
            END
        ) max_laptop,
        MAX(
            CASE
                WHEN p.type = 'Printer' THEN pr.price
            END
        ) max_printer,
        MAX(
            CASE
                WHEN p.type = 'PC' THEN pc.price
            END
        ) max_pc
    FROM
        Product p
        LEFT JOIN Laptop l ON p.model = l.model
        LEFT JOIN PC pc ON p.model = pc.model
        LEFT JOIN Printer pr ON p.model = pr.model
    GROUP BY
        p.maker
)
SELECT
    maker,
    max_laptop,
    max_pc,
    max_printer
FROM
    max_prices
WHERE
    max_laptop IS NOT NULL
    OR max_pc IS NOT NULL
    OR max_printer IS NOT NULL