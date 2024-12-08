-- Запрос37: Выбрать название марки и модели автомобиля, который ремонтировался чаще других.

SELECT
    mark,
    model,
    COUNT(o.id_order) AS repairs_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
GROUP BY
    mark,
    model
ORDER BY
    repairs_count DESC
LIMIT
    1;
