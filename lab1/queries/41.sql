--Запрос41 :Выбрать название марки название модели и название запчасти которую приходится менять для данной модели чаще других .
-- Вставка данных для таблицы person
INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

-- Вставка данных для таблицы master
INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person)
VALUES
(1, '1985-01-01', 'Автослесарь', 10, 4.5, 1),
(2, '1990-02-02', 'Механик', 8, 4.2, 2);

-- Вставка данных для таблицы car
INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 2);

-- Вставка данных для таблицы spare_part
INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(101, 'Тормозные колодки', 'Передние', 10, 'шт.', 200, 'Тормозная система'),
(102, 'Фильтр масла', 'Стандартный', 20, 'шт.', 100, 'Двигатель'),
(103, 'Воздушный фильтр', 'Стандартный', 15, 'шт.', 150, 'Двигатель');

-- Вставка данных для таблицы order_
INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', 1),
(2, '2024-02-01', '2024-02-10', '2024-02-12', 4000, 'Замена тормозов и фильтра', TRUE, 'A123BC', 1),  -- тот же автомобиль (A123BC)
(3, '2024-03-01', '2024-03-10', '2024-03-08', 3000, 'Замена фильтра и тормозных колодок', TRUE, 'B456CD', 2),
(4, '2024-03-15', '2024-03-20', '2024-03-18', 2000, 'Замена фильтра масла', TRUE, 'B456CD', 2); -- тот же автомобиль (B456CD)

-- Вставка данных для таблицы order_of_spare_part
INSERT INTO order_of_spare_part (id_order, code, count)
VALUES
(1, 101, 1),  -- Замена тормозных колодок на ModelX
(1, 102, 1),  -- Замена фильтра масла на ModelX
(2, 101, 1),  -- Повторная замена тормозных колодок на ModelX
(2, 102, 1),  -- Повторная замена фильтра масла на ModelX
(3, 101, 1),  -- Замена тормозных колодок на ModelY
(3, 102, 1),  -- Замена фильтра масла на ModelY
(4, 102, 1);  -- Повторная замена фильтра масла на ModelY



SELECT
    c.mark,
    c.model,
    sp.name_spare_part,
    COUNT(os.count) AS replacement_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part os ON o.id_order = os.id_order
    JOIN spare_part sp ON os.code = sp.code
GROUP BY
    c.mark,
    c.model,
    sp.name_spare_part
ORDER BY
    c.mark,
    c.model,
    replacement_count DESC;
