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


-- Основной запрос:
-- Извлекает данные о каждом поставщике (поля p.name_provider — название поставщика) и 
-- подсчитывает количество заказов (COUNT(o.id_order)) за прошлый год, 
-- сделанных с использованием запчастей этого поставщика.

-- LEFT JOIN order_of_spare_part oos ON p.id_provider = oos.id_order — 
-- соединяет таблицу provider с таблицей order_of_spare_part, 
-- чтобы получить информацию о заказах, связанную с конкретными поставщиками.

-- LEFT JOIN order_ o ON oos.id_order = o.id_order — 
-- соединяет таблицу заказов с таблицей order_of_spare_part, чтобы получить данные о самих заказах.
-- WHERE o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year' 
-- AND o.date_of_receipt < date_trunc('year', current_date) — ограничивает выборку заказами, которые были получены в прошлом году.


-- date_trunc('unit', date) 
-- 1 аргумент — единица времени, до которой будет округляться дата. Это может быть:
-- 'year' — до начала года,
-- 'month' — до начала месяца,
-- 'day' — до начала дня,
-- 'hour' — до начала часа,
-- и так далее.
-- date — дата или временная метка, которую нужно округлить.