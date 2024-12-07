--Запрос39 :Выбрать все данные о заказе с самым продолжительным сроком исполнения .

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

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', NULL),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'B456CD', NULL),
(3, '2024-03-01', '2024-03-20', '2024-03-22', 8000, 'Ремонт трансмиссии', TRUE, 'C789EF', NULL);


SELECT
    *
FROM
    order_
ORDER BY
    planned_completion - date_of_receipt DESC
LIMIT
    (1);