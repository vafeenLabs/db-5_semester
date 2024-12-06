-- Вставка данных для демонстрации
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

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2023-01-01', '2023-01-10', '2023-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', 1),  -- Выполнен раньше срока
(2, '2023-02-01', '2023-02-15', '2023-02-14', 3000, 'Замена тормозов', TRUE, 'A123BC', 1),  -- Выполнен вовремя
(3, '2023-03-01', '2023-03-10', '2023-03-15', 4000, 'Ремонт кузова', TRUE, 'B456CD', 2);  -- Просрочен

SELECT
    COUNT(CASE 
        WHEN actual_completion > planned_completion THEN 1
        ELSE NULL
    END) AS overdue_orders,
    COUNT(CASE 
        WHEN actual_completion = planned_completion THEN 1
        ELSE NULL
    END) AS on_time_orders,
    COUNT(CASE 
        WHEN actual_completion < planned_completion THEN 1
        ELSE NULL
    END) AS early_orders
FROM
    order_
WHERE
    EXTRACT(YEAR FROM date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1;
