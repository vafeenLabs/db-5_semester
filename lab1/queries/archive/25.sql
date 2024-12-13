-- Запрос 25: Для каждой автомашины вывести количество замен различных запчастей в прошлом году.

SELECT
    c.number,
    COUNT(DISTINCT op.code) AS parts_replaced_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part op ON o.id_order = op.id_order
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY
    c.number
ORDER BY
    parts_replaced_count DESC,
    c.number ASC;
