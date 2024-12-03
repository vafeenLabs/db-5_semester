-- Запрос 3: Выбрать даты заказов без повторений, отсортированные по убыванию даты.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2),
(3, '1985-07-10', 'Диагностика', 8, 0.6, 3);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2020, 'Седан', 'Toyota', 'Легковой', 'Corolla', 1),
('456DEF', '78', 2019, 'Универсал', 'Ford', 'Коммерческий', 'Focus', 2),
('789GHI', '79', 2021, 'Кроссовер', 'Nissan', 'Легковой', 'Qashqai', 3),
('012JKL', '80', 2022, 'Пикап', 'Chevrolet', 'Коммерческий', 'Colorado', 1);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-01-15', '2024-02-01', '2024-02-05', 1000, 'Комментарий 1', TRUE, '123ABC', 1),
(2, '2024-03-22', '2024-04-01', '2024-04-04', 1500, 'Комментарий 2', FALSE, '456DEF', 2),
(3, '2024-02-10', '2024-02-20', '2024-02-25', 1200, 'Комментарий 3', TRUE, '789GHI', 3),
(4, '2024-01-15', '2024-02-10', '2024-02-15', 1100, 'Комментарий 4', TRUE, '012JKL', 1);

SELECT
    DISTINCT date_of_receipt
FROM
    order_
ORDER BY
    date_of_receipt DESC;
