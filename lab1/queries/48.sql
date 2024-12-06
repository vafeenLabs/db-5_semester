-- 48. Выбрать марку, модель, госномер автомобилей, на которых делали замену, как самой дорогой, так и самой дешевой запчасти.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Сидоров', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234'),
(4, 'Сергей', 'Иванов', 'Петрович', '89005551234');

INSERT INTO master (id_master, specialization, experience, work_rate, id_person) VALUES
(1, 'Автослесарь', 5, 100, 1),
(2, 'Механик', 3, 120, 2),
(3, 'Электрик', 6, 110, 3),
(4, 'Диагност', 4, 115, 4);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(1, 'Болт', 'Маленький', 100, 'шт', 50, 'Металл'),
(2, 'Фара', 'Передняя', 30, 'шт', 5000, 'Электроника'),
(3, 'Тормозные колодки', 'Передние', 50, 'шт', 2000, 'Запчасти'),
(4, 'Колесо', 'Заднее', 15, 'шт', 1500, 'Запчасти'),
(5, 'Ремень', 'Поясной', 200, 'шт', 10, 'Автотовары');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2020, 'Седан', 'Toyota', 'Легковой', 'Corolla', 1),
('456DEF', '78', 2019, 'Универсал', 'Ford', 'Коммерческий', 'Focus', 2),
('789GHI', '79', 2021, 'Кроссовер', 'Nissan', 'Легковой', 'Qashqai', 3),
('012JKL', '80', 2022, 'Пикап', 'Chevrolet', 'Коммерческий', 'Colorado', 4);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-11-01', '2024-11-05', '2024-11-04', 5200, 'Замена запчастей', TRUE, '123ABC', 1),
(2, '2024-11-02', '2024-11-06', '2024-11-06', 2500, 'Обслуживание', TRUE, '456DEF', 2),
(3, '2024-11-03', '2024-11-07', '2024-11-07', 3000, 'Техническое обслуживание', TRUE, '789GHI', 3),
(4, '2024-11-04', '2024-11-08', '2024-11-08', 7000, 'Запчасти заменены', TRUE, '012JKL', 4);

INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 1, 2), 
(1, 5, 1),  
(2, 3, 1),
(2, 4, 1),  
(3, 1, 1),  
(3, 2, 1),  
(4, 5, 1),  -- Ремень для заказа 4 (дешёвая запчасть)
(4, 2, 1);  -- Фара для заказа 4 (дешёвая запчасть)

WITH max_min_spare_parts AS (
    SELECT 
        MAX(sp.cost) AS max_cost, 
        MIN(sp.cost) AS min_cost
    FROM 
        spare_part sp
)
SELECT 
    c.mark, 
    c.model, 
    c.number,
    MAX(sp.cost) AS expensive_cost,
    MIN(sp.cost) AS cheap_cost,
    (SELECT name_spare_part 
     FROM spare_part sp2
     WHERE sp2.cost = MAX(sp.cost)
     LIMIT 1) AS expensive_spare_part,
    (SELECT name_spare_part 
     FROM spare_part sp2
     WHERE sp2.cost = MIN(sp.cost)
     LIMIT 1) AS cheap_spare_part
FROM 
    car c
JOIN 
    order_ o ON c.number = o.number
JOIN 
    order_of_spare_part o_sp ON o.id_order = o_sp.id_order
JOIN 
    spare_part sp ON o_sp.code = sp.code
JOIN
    max_min_spare_parts mmsp ON sp.cost = mmsp.max_cost OR sp.cost = mmsp.min_cost
GROUP BY 
    c.number, c.mark, c.model
HAVING
    MAX(sp.cost) = (SELECT max_cost FROM max_min_spare_parts)
    AND MIN(sp.cost) = (SELECT min_cost FROM max_min_spare_parts);
