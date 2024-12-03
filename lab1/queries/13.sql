-- Запрос 13: Вывести суммарную стоимость имеющихся на складе запчастей.

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(1, 'Тормозные колодки', NULL, 10, 'шт.', 1500, 'Тормозная система'),
(2, 'Масло моторное', NULL, 20, 'л.', 500, 'Масла'),
(3, 'Фильтр воздушный', NULL, 15, 'шт.', NULL, 'Фильтры'),
(4, 'Свечи зажигания', NULL, 5, 'шт.', 200, 'Электрическая система');

SELECT
    SUM(cost * quantity) AS total_cost
FROM
    spare_part
WHERE
    quantity > 0 AND cost IS NOT NULL; -- Условие для исключения неверных записей