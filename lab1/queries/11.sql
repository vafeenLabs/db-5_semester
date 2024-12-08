-- Запрос 11: Выбрать максимальный и минимальный сроки исполнения заказов.

SELECT
    MAX(planned_completion - date_of_receipt) AS max_duration,
    MIN(planned_completion - date_of_receipt) AS min_duration
FROM
    order_;