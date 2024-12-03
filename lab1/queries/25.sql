-- Запрос 25: Для каждой автомашины вывести количество замен различных запчастей в прошлом году.


-- Вставка данных в таблицу spare_part (запчасти)
INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(101, 'Масляный фильтр', 'Фильтр для масла', 100, 'шт', 500, 'Механика'),
(102, 'Тормозные колодки', 'Колодки для тормозной системы', 50, 'шт', 1200, 'Тормозная система'),
(106, 'Воздушный фильтр', 'Фильтр для воздуха', 30, 'шт', 800, 'Фильтрация'),
(107, 'Тормозной диск', 'Диск для тормозной системы', 20, 'шт', 1500, 'Тормозная система');

-- Вставка данных в таблицу person (персональные данные)
INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

-- Вставка данных в таблицу master (мастера)
INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Автомеханик', 10, 1.5, 1),  -- мастер 1
(2, '1985-08-20', 'Электрик', 8, 1.3, 2);  -- мастер 2

-- Вставка данных в таблицу car (автомобили)
INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', 1),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', 1);

-- Вставка данных в таблицу order_ (заказы)
INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2023-05-01', '2023-05-10', '2023-05-10', 1000, 'Замена масла', TRUE, 'A123BC', 1),
(2, '2023-06-15', '2023-06-20', '2023-06-20', 1500, 'Замена тормозных колодок', FALSE, 'A123BC', 2),
(5, '2023-09-05', '2023-09-10', '2023-09-10', 2500, 'Замена масла и тормозных колодок', FALSE, 'A123BC', 1),
(7, '2023-12-01', '2023-12-10', '2023-12-10', 1300, 'Замена масла', TRUE, 'C789EF', 1),
(8, '2023-12-10', '2023-12-15', '2023-12-15', 1100, 'Замена тормозных колодок', TRUE, 'C789EF', 2);

-- Вставка данных в таблицу order_of_spare_part (заказы запчастей)
INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 101, 1),
(2, 102, 1),
(5, 101, 1),
(5, 102, 1),
(7, 106, 1),
(8, 107, 1);

-- Запрос для подсчета количества замен различных запчастей для каждой автомашины в прошлом году
SELECT
    c.number,
    COUNT(DISTINCT op.code) AS parts_replaced_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part op ON o.id_order = op.id_order
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY
    c.number
ORDER BY
    parts_replaced_count DESC,
    c.number ASC;
