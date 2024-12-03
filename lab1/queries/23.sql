-- 23. Вывести название запчастей, которые были заменены как минимум на трех машинах марки Хонда.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '12345678902'),
(3, 'Сергей', 'Сергеев', 'Сергеевич', '12345678903'),
(4, 'Алексей', 'Алексеев', 'Алексеевич', '12345678904');

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(1, 'Масло моторное', NULL, 100, 'л', 500, 'жидкости'),
(2, 'Фильтр масляный', NULL, 50, 'шт', 150, 'фильтры'),
(3, 'Свечи зажигания', NULL, 200, 'шт', 300, 'запчасти');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '777', 2020, 'легковой', 'Civic', 'седан', 'Хонда', 1),
('B456CD', '777', 2019, 'легковой', 'Accord', 'седан', 'Хонда', 2),
('C789EF', '777', 2021, 'легковой', 'CR-V', 'внедорожник', 'Хонда', 3),
('D012GH', '777', 2020, 'легковой', 'Camry', 'седан', 'Тойота', 4),
('E345IJ', '777', 2022, 'легковой', 'Pilot', 'внедорожник', 'Хонда', 4);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number) VALUES
(1,'2024-01-01','2024-01-07','2024-01-06', 500,'Замена масла','true','A123BC'),
(2,'2024-01-02','2024-01-08','2024-01-07', 300,'Замена фильтра','true','B456CD'),
(3,'2024-01-03','2024-01-09','2024-01-08', 400,'Замена свечей','true','C789EF'),
(4,'2024-01-04','2024-01-10','2024-01-09', 600,'Замена масла','false','E345IJ'),
(5,'2024-01-05','2024-01-11','2024-01-10', 450,'Замена масла','true','B456CD');

INSERT INTO order_of_spare_part (id_order , code , count) VALUES 
(1 , 1 , 5),   -- Масло моторное на A123BC
(2 , 2 , 3),   -- Фильтр масляный на B456CD
(3 , 3 , 10),  -- Свечи зажигания на C789EF
(4 , 1 , 7),   -- Масло моторное на E345IJ
(5 , 1 , 10);  -- Масло моторное на B456CD


SELECT sp.name_spare_part, COUNT(DISTINCT c.number)
FROM spare_part sp
JOIN order_of_spare_part osp ON sp.code = osp.code
JOIN order_ o ON osp.id_order = o.id_order
JOIN car c ON o.number = c.number
WHERE c.mark = 'Хонда'
GROUP BY sp.name_spare_part
HAVING COUNT(DISTINCT c.number) >= 3;