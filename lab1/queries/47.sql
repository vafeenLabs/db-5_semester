
--- 47. Выбрать названия запчастей, которые устанавливались на самые старые автомобили.
-- Вставка данных в таблицу person
INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '1234567890'),
(2, 'Петр', 'Петров', 'Петрович', '0987654321');

-- Вставка данных в таблицу car
INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'Седан', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2018, 'Кроссовер', 'ModelY', 'Кроссовер', 'BMW', 2);

-- Вставка данных в таблицу spare_part
INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(1, 'Тормозные колодки', 'Передние', 100, 'шт.', 1500, 'Запчасть для тормозной системы'),
(2, 'Фильтр воздушный', 'Основной', 500, 'шт.', 500, 'Фильтры'),
(3, 'Ремень генератора', 'Короткий', 200, 'шт.', 800, 'Ремни');

-- Вставка данных в таблицу order_
INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-05', '2024-01-04', 2000, 'Заменить колодки', true, 'A123BC', NULL),
(2, '2024-02-01', '2024-02-05', '2024-02-03', 1500, 'Поменять фильтр', true, 'B456CD', NULL);

-- Вставка данных в таблицу order_of_spare_part
INSERT INTO order_of_spare_part (id_order, code, count)
VALUES
(1, 1, 2),  -- Тормозные колодки
(2, 2, 1);  -- Фильтр воздушный


SELECT
    sp.name_spare_part
FROM
    order_of_spare_part oos
    JOIN order_ o ON oos.id_order = o.id_order
    JOIN car c ON o.number = c.number
    JOIN spare_part sp ON oos.code = sp.code
WHERE
    c.year = (
        SELECT
            MIN(year)
        FROM
            car
    );
