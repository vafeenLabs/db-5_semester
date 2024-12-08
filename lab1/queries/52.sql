-- 52. Выбрать названия поставщиков, количество заказов в прошлом году, процентное отношение ко всем заказам прошлого года.

SELECT
    p.name_provider,
    COUNT(o.id_order) AS total_orders,
    ROUND(
        COUNT(o.id_order) * 100.0 / (
            SELECT
                COUNT(*)
            FROM
                order_ o
            WHERE
                o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year'
                AND o.date_of_receipt < date_trunc('year', current_date)
        ),
        2
    ) AS percentage
FROM
    provider p
    LEFT JOIN order_of_spare_part oos ON p.id_provider = oos.id_order
    LEFT JOIN order_ o ON oos.id_order = o.id_order
WHERE
    o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year'
    AND o.date_of_receipt < date_trunc('year', current_date)
GROUP BY
    p.name_provider;
