-- Запрос 18: Для каждой даты поступления заказа вывести название времени года
-- и остальные данные: дату поступления, срок выполнения и стоимость.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('B456DE', '456', 2018, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-01-15', '2024-01-20', NULL ,5000 ,NULL ,TRUE ,'A123BC' ,1), -- Зима
(2,'2024-04-10','2024-04-15',NULL ,3000 ,NULL ,FALSE ,'B456DE' ,2), -- Весна
(3,'2024-07-05','2024-07-10',NULL ,4500 ,NULL ,TRUE ,'A123BC' ,1), -- Лето
(4,'2024-10-25','2024-10-30',NULL ,2500 ,NULL ,FALSE ,'B456DE' ,2); -- Осень

SELECT
    CASE
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (12, 1, 2) THEN 'Зима'
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (3, 4, 5) THEN 'Весна'
        WHEN EXTRACT(MONTH FROM date_of_receipt) IN (6, 7, 8) THEN 'Лето'
        ELSE 'Осень'
    END AS season,
    date_of_receipt,
    planned_completion,
    sum_of_cost
FROM
    order_;