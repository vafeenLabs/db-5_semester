-- Запрос 20: Выбрать фамилии, имена, отчества мастеров,
-- которые выполнили не более пяти заказов.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);


INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', '2018', 'Легковой', 'Camry', 'Седан', 'Toyota', 1),
('B456CD', '78', '2021', 'Легковой', 'Corolla', 'Хэтчбек', 'Toyota', 2),
('C789DE', '79', '2015', 'Грузовой', 'Actros', 'Фургон', 'Mercedes', 3);

-- Вставляем заказы с корректными номерами автомобилей и мастерами
INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-12-01', NULL , NULL ,5000 ,NULL ,TRUE ,'A123BC' ,1), -- Заказ для мастера 1
(2,'2024-12-05' ,NULL ,NULL ,3000 ,NULL ,FALSE ,'B456CD' ,1), -- Заказ для мастера 1
(3,'2024-12-10' ,NULL ,NULL ,4500 ,NULL ,TRUE ,'A123BC' ,1), -- Заказ для мастера 1
(4,'2024-12-15' ,NULL ,NULL ,2000 ,NULL ,FALSE ,'B456CD' ,2), -- Заказ для мастера 2
(5,'2024-12-20' ,NULL ,NULL ,3500 ,NULL ,TRUE ,'C789DE' ,2); -- Заказ для мастера 2

SELECT
    p.surname,
    p.name,
    p.patronymic,
    COUNT(o.id_order) AS orders_count
FROM
    master m
    LEFT JOIN person p ON m.id_person = p.id_person 
    LEFT JOIN order_ o ON m.id_master = o.id_master 
GROUP BY
    m.id_master,
    p.surname,
    p.name,
    p.patronymic
HAVING
    COUNT(o.id_order) <= 5;
