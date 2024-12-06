-- Таск: Запрос 29: Выбрать госномер автомобиля,
-- дату последнего обращения и если были замены запчастей, то наименования запчастей.
-- Вставка данных
INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', NULL),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', NULL),
('B456DE', '78', 2021, 'Кроссовер', 'Kona', 'Кроссовер', 'Hyundai', NULL),
('D987JK', '70', 2022, 'Седан', 'Model S', 'Люксовый', 'Tesla', NULL),
('E321HJ', '71', 2021, 'Пикап', 'F-150', 'Пикап', 'Ford', NULL);

INSERT INTO order_ (id_order, number, date_of_receipt) VALUES
(1, 'A123BC', '2023-01-15'),
(2, 'C789EF', '2023-03-20'),
(3, 'B456DE', '2023-06-10'),
(4, 'B456DE', '2023-09-05'),
(5, 'D987JK', '2023-11-12');

INSERT INTO spare_part (code, name_spare_part, category) VALUES
(101, 'Фильтр масляный', 'Двигатель'),
(102, 'Свечи зажигания', 'Двигатель'),
(103, 'Тормозные колодки', 'Тормоза');

INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 101, 1),
(3, 102, 1),
(3, 103, 1),
(4, 103, 1),
(5, 101, 1);

SELECT
    c.number,
    MAX(o.date_of_receipt) as last_service_date,
    STRING_AGG(sp.name_spare_part, ', ') as replaced_parts_names
FROM
    car c
    LEFT JOIN order_ o ON c.number = o.number
    LEFT JOIN order_of_spare_part op ON o.id_order = op.id_order
    LEFT JOIN spare_part sp ON op.code = sp.code
GROUP BY
    c.number;
