--Запрос39 :Выбрать все данные о заказе с самым продолжительным сроком исполнения .

SELECT
    *
FROM
    order_
ORDER BY
    planned_completion - date_of_receipt DESC
LIMIT
    (1);