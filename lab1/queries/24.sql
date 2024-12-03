-- Запрос 24: Выбрать названия неисправностей, которые устраняет только один мастер.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

INSERT INTO malfunction (id_malfunction, name_malfunction) VALUES
(1, 'Неисправность 1'),
(2, 'Неисправность 2'),
(3, 'Неисправность 3');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-01-01', 'Специалист по ремонту автомобилей', 10, 1.5, 1),
(2, '1985-05-05', 'Специалист по диагностике', 8, 1.2, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', 1),
('B456CD', '78', 2019, 'Кроссовер', 'BMW', 'Внедорожник', 'BMW', 2);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-12-01', '2024-12-10', '2024-12-10', 1500, 'Комментарий 1', TRUE, 'A123BC', 1),
(2, '2024-12-02', '2024-12-12', '2024-12-12', 2000, 'Комментарий 2', FALSE, 'B456CD', 2);

INSERT INTO order_malfunction (id_order, id_malfunction) VALUES
(1, 1), -- заказ 1 устраняет неисправность 1
(2, 2), -- заказ 2 устраняет неисправность 2
(2, 1); -- заказ 2 устраняет неисправность 1

SELECT m.name_malfunction
FROM malfunction m
WHERE m.id_malfunction IN (
    SELECT om.id_malfunction
    FROM order_malfunction om
    JOIN order_ o ON o.id_order = om.id_order
    JOIN master ma ON ma.id_master = o.id_master
    GROUP BY om.id_malfunction
    HAVING COUNT(DISTINCT ma.id_master) = 1
);
