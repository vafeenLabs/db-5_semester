--Запрос40 :Выбрать фамилию имя отчество владельца госномер автомобиля на который был сделан самый дорогой заказ .


INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012'),
(3, 'Сергей', 'Сергеев', 'Сергеевич', '34567890123');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person)
VALUES
(1, '1985-01-01', 'Автослесарь', 10, 4.5, 1),
(2, '1990-02-02', 'Механик', 8, 4.2, 2);


INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 2),
('C789EF', '79', 2020, 'грузовой', 'ModelZ', 'Пикап', 'Ford', 3);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', 1),
(2, '2024-02-01', '2024-02-10', '2024-02-12', 12000, 'Замена тормозов и фильтра', TRUE, 'B456CD', 2),
(3, '2024-03-01', '2024-03-10', '2024-03-08', 20000, 'Ремонт трансмиссии', TRUE, 'C789EF', 2);

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.number
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
    JOIN order_ o ON c.number = o.number
ORDER BY
    sum_of_cost DESC
LIMIT
    (1);