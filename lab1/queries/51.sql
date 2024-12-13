-- 51. Выбрать все даты прошлого месяца, в которые не осуществляли замену запчастей.

SELECT
    DISTINCT o.date_of_receipt
FROM
    order_ o
WHERE
    o.date_of_receipt >= date_trunc('month', current_date) - INTERVAL '1 month'
    AND o.date_of_receipt < date_trunc('month', current_date)
    AND NOT EXISTS (
        SELECT
            1
        FROM
            order_of_spare_part oos
        WHERE
            oos.id_order = o.id_order
    );

-- Основной запрос:
-- Извлекает уникальные даты получения заказов (date_of_receipt) из таблицы order_ за прошлый месяц. 
-- То есть он выбирает заказы, полученные в месяц, предшествующий текущему.

-- Условие o.date_of_receipt >= date_trunc('month', current_date) - INTERVAL '1 month' выбирает все заказы, 
-- полученные начиная с первого дня прошлого месяца.
-- Условие o.date_of_receipt < date_trunc('month', current_date) ограничивает выборку до конца прошлого месяца, 
-- исключая текущий месяц.

-- Подзапрос с NOT EXISTS:
-- Запрос проверяет, что для каждого заказа в основной выборке не существует записи 
-- в таблице order_of_spare_part (таблице, связывающей заказы и запчасти), то есть заказы, 
-- для которых не были использованы запчасти.

-- NOT EXISTS (SELECT 1 FROM order_of_spare_part oos WHERE oos.id_order = o.id_order) исключает все заказы, 
-- для которых есть хотя бы одна запчасть, указанная в таблице order_of_spare_part.