-- Запрос 17: Для каждого автомобиля выбрать количество различных запчастей, которые были заменены в текущем году.

SELECT
    c.number,
    COUNT(DISTINCT os.code) AS parts_replaced_count
FROM
    order_of_spare_part os
    JOIN order_ o ON os.id_order = o.id_order
    JOIN car c ON o.number = c.number
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    c.number;