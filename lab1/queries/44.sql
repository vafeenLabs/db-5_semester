-- Запрос 44: Выбрать автомобиль, на котором ни одну запчасть не меняли дважды.

INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person)
VALUES
(1, '1985-01-01', 'Автослесарь', 10, 4.5, 1),
(2, '1990-02-02', 'Механик', 8, 4.2, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 2);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(101, 'Тормозные колодки', 'Передние', 10, 'шт.', 200, 'Тормозная система'),
(102, 'Фильтр масла', 'Стандартный', 20, 'шт.', 100, 'Двигатель');

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', 1),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'A123BC', 1),  -- Новый заказ для того же автомобиля
(3, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена фильтра', TRUE, 'B456CD', 2);  -- Новый заказ для другого автомобиля

INSERT INTO order_of_spare_part (id_order, code, count)
VALUES
(1, 101, 1),
(1, 102, 1),
(2, 101, 1),  -- Тормозные колодки заменены повторно, но в другом заказе
(3, 102, 1);  -- Фильтр масла заменен в новом заказе

SELECT
    O.number
FROM
    order_ O
    JOIN order_of_spare_part OP ON O.id_order = OP.id_order
GROUP BY
    O.number
HAVING
    COUNT(OP.code) = COUNT(DISTINCT OP.code);
