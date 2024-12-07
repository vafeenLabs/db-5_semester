-- Запрос 19: Для каждого года вывести количество выпущенных автомобилей,
-- ремонтировавшихся в текущем месяце.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('B456DE', '456', 2018, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2),
('C789FG', '789', 2020, 'Грузовой', 'Mercedes-Benz Actros', 'Шасси', 'Mercedes-Benz', 3);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-12-01', NULL , NULL ,5000 ,NULL ,TRUE ,'A123BC' ,1), -- Ремонт в текущем месяце
(2,'2024-12-05' ,NULL ,NULL ,3000 ,NULL ,FALSE ,'B456DE' ,2), -- Ремонт в текущем месяце
(3,'2024-12-10' ,NULL ,NULL ,4500 ,NULL ,TRUE ,'C789FG' ,1); -- Ремонт в текущем месяце

SELECT
    year,
    COUNT(*) AS cars_repaired_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
WHERE
    EXTRACT(MONTH FROM o.date_of_receipt) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    year;