with D as(
    Select
        model,
        price
    FROM
        PC
    UNION
    SELECT
        model,
        price
    from
        Laptop
    UNION
    SELECT
        model,
        price
    from
        Printer
)
SELECT
    DISTINCT Product.maker,
    CASE
        WHEN MAX(
            CASE
                WHEN D.price IS NULL THEN 1
                ELSE 0
            END
        ) = 0 THEN MAX(D.price)
    END
FROM
    Product
    RIGHT JOIN D ON Product.model = D.model
GROUP BY
    Product.maker