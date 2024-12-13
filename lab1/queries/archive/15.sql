-- Запрос 15: Выбрать названия запчастей, сокращенное название единиц измерения,
-- количество запчастей в наличии для конкретной категории (например, 'Brakes').


SELECT
    name_spare_part,
    units_of_measurement,
    quantity
FROM
    spare_part
WHERE
    category = 'Фильтры';