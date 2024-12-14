SELECT
T.maker,
T.type,
ROUND(COUNT(p.model)* 100.0 / NULLIF(total_models.total_count, 0), 2) AS PRC
FROM
(
SELECT DISTINCT maker, 'PC' AS type FROM Product
UNION ALL
SELECT DISTINCT maker, 'Laptop' FROM Product
UNION ALL
SELECT DISTINCT maker, 'Printer' FROM Product
) T
LEFT JOIN Product p ON T.maker = p.maker AND T.type = p.type
JOIN (
SELECT maker, COUNT(model) AS total_count
FROM Product
GROUP BY maker
)
total_models ON T.maker = total_models.maker
GROUP BY T.maker, T.type, total_models.total_count;