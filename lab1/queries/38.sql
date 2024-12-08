-- Запрос38: Выбрать все данные об автомобилях для которых не производились замены запчастей.

SELECT
    *
FROM
    car
WHERE
    number NOT IN (
        SELECT
            DISTINCT number
        FROM
            order_
            INNER JOIN order_of_spare_part ON order_.id_order = order_of_spare_part.id_order
    );
