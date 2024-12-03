-- Запрос 15: Выбрать названия запчастей, сокращенное название единиц измерения,
-- количество запчастей в наличии для конкретной категории (например, 'Brakes').

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(1, 'Тормозные колодки', NULL, 10, 'шт.', 1500, 'Тормозная система'),
(2, 'Масло моторное', NULL, 20, 'л.', 500, 'Масла'),
(3, 'Фильтр воздушный', NULL, 15, 'шт.', 300, 'Фильтры'),
(4, 'Фильтр масляный', NULL, 5, 'шт.', 200, 'Фильтры'),
(5, 'Свечи зажигания', NULL, 8, 'шт.', 1000, 'Электрическая система');

SELECT
    name_spare_part,
    units_of_measurement,
    quantity
FROM
    spare_part
WHERE
    category = 'Фильтры';