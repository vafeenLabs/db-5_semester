-- Запрос 34: Для каждого поставщика выбрать названия всех категорий запчастей
-- и количество различных запчастей им поставляемых. Если поставщик не поставляет 
-- запчасти какой-то категории вывести ноль. Результат отсортировать по id поставщика и по названию категории.

SELECT
    p.name_provider,
    COALESCE(sp.category, 'Unknown') AS category_name,
    COUNT(DISTINCT sp.code) AS parts_count
FROM
    provider p
    LEFT JOIN spare_part sp ON TRUE  -- Соединяем всех поставщиков с запчастями
    LEFT JOIN order_of_spare_part op ON sp.code = op.code  -- Связываем с заказами
    LEFT JOIN "order_" o ON op.id_order = o.id_order  -- Связываем с таблицей заказов
WHERE
    o.id_provider = p.id_provider OR o.id_provider IS NULL  -- Поставщик связан с заказом
GROUP BY
    p.name_provider,
    sp.category
ORDER BY
    p.id_provider,
    category_name;



-- Функция COALESCE используется для замены значений NULL на заданное значение.