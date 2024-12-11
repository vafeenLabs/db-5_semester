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

-- EXTRACT(MONTH FROM date_of_receipt)
-- Извлекается номер месяца из даты date_of_receipt.

-- WHEN ... THEN ...
-- На основе значения месяца определяется сезон:

-- Если месяц 12, 1, или 2, то возвращается строка 'Зима' (зимний период).
-- Если месяц 3, 4, или 5, то возвращается строка 'Весна' (весенний период).
-- Если месяц 6, 7, или 8, то возвращается строка 'Лето' (летний период).
-- Для всех остальных значений (9, 10, 11), возвращается строка 'Осень' (осенний период).