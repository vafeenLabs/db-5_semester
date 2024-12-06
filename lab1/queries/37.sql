-- Запрос37: Выбрать название марки и модели автомобиля, который ремонтировался чаще других.

INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1), -- Ремонтируется 3 раза
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 2); -- Ремонтируется 2 раза

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', NULL),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'B456CD', NULL),
(3, '2024-03-01', '2024-03-10', '2024-03-09', 4000, 'Ремонт трансмиссии', TRUE, 'A123BC', NULL),
(4, '2024-04-01', '2024-04-10', '2024-04-09', 3500, 'Замена масла', TRUE, 'A123BC', NULL),
(5, '2024-05-01', '2024-05-15', '2024-05-14', 2500, 'Ремонт подвески', TRUE, 'B456CD', NULL);

SELECT
    mark,
    model,
    COUNT(o.id_order) AS repairs_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
GROUP BY
    mark,
    model
ORDER BY
    repairs_count DESC
LIMIT
    1;
