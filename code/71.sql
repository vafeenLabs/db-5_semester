SELECT
    p.maker
FROM
    Product p
    JOIN PC pc ON p.model = pc.model
WHERE
    p.type = 'PC'
GROUP BY
    p.maker
HAVING
    COUNT(DISTINCT p.model) =(
        SELECT
            COUNT(DISTINCT p2.model)
        FROM
            Product p2
        WHERE
            p2.maker = p.maker
            AND p2.type = 'PC'
    )