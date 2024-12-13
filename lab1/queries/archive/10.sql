-- Запрос 10: Выбрать среднюю стоимость заказов.

SELECT AVG(sum_of_cost) AS average_order_cost
FROM order_;