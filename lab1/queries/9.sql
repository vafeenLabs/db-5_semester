-- Запрос 9: Выбрать все данные о заказах с символами «%», «/», «\», «-» в комментариях

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('B456DE', '456', 2018, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2);

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-01-01', '2024-01-05', NULL, 5000, 'Замена масла / фильтра.', TRUE, 'A123BC', 1),
(2, '2024-01-02', '2024-01-06', NULL, 3000, NULL, FALSE, 'B456DE', 2),
(3, '2024-01-03', NULL, NULL, 7000, 'Проблемы с тормозами - срочный ремонт.', TRUE, 'A123BC', 1),
(4, '2024-01-04', NULL, NULL, 2000, 'Необходима диагностика \ системы.', FALSE, NULL, NULL),
(5, '2024-01-05', NULL, NULL, 4000, 'Обслуживание автомобиля % скидка.', TRUE, NULL ,NULL); -- Комментарий с символом %

SELECT *
FROM order_
WHERE comment LIKE '%/%'
   OR comment LIKE '%-%'
   OR comment LIKE '%\\%'
   OR comment LIKE '%\%%';