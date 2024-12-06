-- Запрос38: Выбрать все данные об автомобилях для которых не производились замены запчастей.

INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012'),
(3, 'Сергей', 'Сергеев', 'Сергеевич', '34567890123');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 2),
('C789EF', '79', 2020, 'грузовой', 'ModelZ', 'Пикап', 'Ford', 3);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(101, 'Тормозные колодки', 'Передние', 10, 'шт.', 200, 'Тормозная система'),
(102, 'Фильтр масла', 'Стандартный', 20, 'шт.', 100, 'Двигатель');

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', NULL),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'B456CD', NULL);

INSERT INTO order_of_spare_part (id_order, code, count)
VALUES
(1, 101, 1), -- Для автомобиля A123BC
(2, 102, 1); -- Для автомобиля B456CD

SELECT
    *
FROM
    car
WHERE
    number NOT IN (
        SELECT
            DISTINCT number
        FROM
            order_
            INNER JOIN order_of_spare_part ON order_.id_order = order_of_spare_part.id_order
    );
