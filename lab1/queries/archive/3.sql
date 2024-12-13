-- Запрос 3: Выбрать даты заказов без повторений, отсортированные по убыванию даты.

SELECT
    DISTINCT date_of_receipt
FROM
    order_
ORDER BY
    date_of_receipt DESC;
