-- Запрос 18: Для каждой даты поступления заказа вывести название времени года
-- и остальные данные: дату поступления, срок выполнения и стоимость.

SELECT
    CASE
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (12, 1, 2) THEN 'Зима'
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (3, 4, 5) THEN 'Весна'
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (6, 7, 8) THEN 'Лето'
        ELSE 'Осень'
    END AS season,
    date_of_receipt,
    planned_completion,
    sum_of_cost
FROM
    order_;