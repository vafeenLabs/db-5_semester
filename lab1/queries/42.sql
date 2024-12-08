-- Запрос 42. Для последнего года выбрать количество просроченных заказов, количество заказов, выполненных вовремя, и количество заказов выполненных раньше срока по строкам. Пример результата:
-- Просроченные заказы
-- 10
-- Заказы в срок
-- 90
-- Заказы раньше срока
-- 20
SELECT
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
WHERE
    EXTRACT(YEAR FROM date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1;
