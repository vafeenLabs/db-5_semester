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
