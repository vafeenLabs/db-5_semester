-- Запрос 34: Для каждого поставщика выбрать названия всех категорий запчастей
-- и количество различных запчастей им поставляемых. Если поставщик не поставляет 
-- запчасти какой-то категории вывести ноль. Результат отсортировать по id поставщика и по названию категории.

SELECT
    p.name_provider,
    COALESCE(sp.category, 'Unknown') AS category_name,
    COUNT(DISTINCT sp.code) AS parts_count
FROM
    provider p
    LEFT JOIN spare_part sp ON p.id_provider = sp.id_provider
GROUP BY
    p.name_provider,
    category_name
ORDER BY
    p.id_provider,
    category_name;


-- Функция COALESCE используется для замены значений NULL на заданное значение.