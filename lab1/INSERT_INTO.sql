INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Сидоров', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234'),
(4, 'Сергей', 'Иванов', 'Петрович', '89005551234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person)
VALUES
(1, '1985-01-01', 'Автослесарь', 10, 4.5, 1),
(2, '1990-02-02', 'Механик', 8, 4.2, 2),
(3, '1980-03-03', 'Автослесарь', 12, 4.8, 3),
(4, '1975-04-04', 'Техник', 15, 5.0, 4);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2020, 'Седан', 'Toyota', 'Легковой', 'Corolla', 1),
('012JKL', '80', 2022, 'Пикап', 'Chevrolet', 'Коммерческий', 'Colorado', 1),
('456DEF', '78', 2019, 'Универсал', 'Ford', 'Коммерческий', 'Focus', 2),
('789GHI', '79', 2021, 'Кроссовер', 'Nissan', 'Легковой', 'Qashqai', 3);


INSERT INTO provider (id_provider, name_provider, adress, name_manager, surname_manager, patronymic_manager, phone_manager) VALUES
(1, 'Поставщик А', 'Улица А, 1', 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Поставщик Б', 'Улица Б, 2', 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Поставщик В', 'Улица В, 3', 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2023-03-15', '2023-03-20', '2023-03-19', 5000, 'Комментарий 1', TRUE, NULL, NULL),
(2, '2023-06-10', '2023-06-15', '2023-06-14', 7000, 'Комментарий 2', TRUE, NULL, NULL),
(3, '2023-12-01', '2023-12-05', '2023-12-05', 10000, 'Комментарий 3', TRUE, NULL, NULL),
(4, '2024-01-10', '2024-01-15', '2024-01-15', 15000, 'Комментарий 4', TRUE, NULL, NULL);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(101, 'Деталь 1', NULL, 10, 'шт', 1000, 'Категория А'),
(102, 'Деталь 2', NULL, 5, 'шт', 2000, 'Категория Б'),
(103, 'Деталь 3', NULL, 8, 'шт', 3000, 'Категория В'),
(104, 'Деталь 4', NULL, 12, 'шт', 4000, 'Категория Г');

INSERT INTO malfunction (id_malfunction, name_malfunction) VALUES
(1, 'Неисправность 1'),
(2, 'Неисправность 2'),
(3, 'Неисправность 3');

INSERT INTO work (id_work, name_work) VALUES
(1, 'Замена детали 1'),
(2, 'Замена детали 2'),
(3, 'Замена детали 3'),
(4, 'Замена детали 4');

INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 101, 5),
(2, 102, 2),
(3, 103, 7),
(4, 104, 3);
