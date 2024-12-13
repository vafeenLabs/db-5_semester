-- Запрос 13: Вывести суммарную стоимость имеющихся на складе запчастей.

SELECT
    SUM(cost * quantity) AS total_cost
FROM
    spare_part
WHERE
    quantity > 0 AND cost IS NOT NULL;