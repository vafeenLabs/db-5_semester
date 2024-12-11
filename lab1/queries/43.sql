-- Запрос 43: Для каждого месяца выбрать количество просроченных заказов,
-- количество заказов выполненных вовремя, и количество заказов выполненных раньше срока по строкам.

-- Основной запрос:
SELECT
    TO_CHAR(date_of_receipt, 'Month') AS month_name,
    COUNT(CASE 
        WHEN actual_completion > planned_completion THEN 1
        ELSE NULL
    END) AS overdue_orders,
    COUNT(CASE 
        WHEN actual_completion = planned_completion THEN 1
        ELSE NULL
    END) AS on_time_orders,
    COUNT(CASE 
        WHEN actual_completion < planned_completion THEN 1
        ELSE NULL
    END) AS early_orders
FROM
    order_
GROUP BY
    TO_CHAR(date_of_receipt, 'Month')
ORDER BY
    TO_CHAR(date_of_receipt, 'Month');

-- TO_CHAR(date_of_receipt, 'Month'): Преобразует дату в текстовый формат, извлекая из нее название месяца.
-- 'Month': Формат, указывающий, что нужно вывести полное название месяца.
