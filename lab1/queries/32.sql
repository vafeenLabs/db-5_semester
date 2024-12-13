-- Запрос 32: Для каждого поставщика вывести названия категорий запчастей,
-- которые он не поставляет.
SELECT
    p.name_provider,
    sp.category
FROM
    provider p
    CROSS JOIN spare_part sp -- Соединяем всех поставщиков с запчастями
    LEFT JOIN order_of_spare_part op ON sp.code = op.code
    LEFT JOIN "order_" o ON op.id_order = o.id_order
WHERE
    o.id_provider != p.id_provider OR o.id_provider IS NULL;


-- CROSS
-- В данном запросе: Все записи из таблицы provider (поставщики) 
-- будут соединены с каждой записью из таблицы spare_part (запчасти). 
-- Это позволяет получить все возможные комбинации поставщиков и категорий 
-- запчастей, включая те, которые поставщики не поставляют.

-- LEFT 
-- В данном запросе: Соединяет таблицу запчастей (spare_part) 
-- с таблицей заказов запчастей (order_of_spare_part) по коду запчасти. 
-- Это необходимо для того, чтобы найти запчасти, которые не были заказаны 
-- (и, следовательно, не поставляются поставщиками).