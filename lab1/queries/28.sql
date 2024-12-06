-- Запрос 28: Выбрать госномер автомобиля,
-- дату последнего обращения и если были замены запчастей то их количество.


INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', NULL),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', NULL),
('B456DE', '78', 2021, 'Кроссовер', 'Kona', 'Кроссовер', 'Hyundai', NULL),
('D987JK', '70', 2022, 'Седан', 'Model S', 'Люксовый', 'Tesla', NULL),
('E321HJ', '71', 2021, 'Пикап', 'F-150', 'Пикап', 'Ford', NULL);


INSERT INTO order_ (id_order, number, date_of_receipt, planned_completion, actual_completion, sum_of_cost, id_master)
VALUES
(1, 'A123BC', '2024-01-10', '2024-01-15', '2024-01-14', 2000, NULL),
(2, 'A123BC', '2024-02-20', '2024-02-25', '2024-02-24', 3000, NULL),
(3, 'B456DE', '2024-03-01', '2024-03-05', '2024-03-04', 1500, NULL);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(101, 'Тормозные колодки', 'Передние', 10, 'шт.', 200, 'Тормозная система'),
(102, 'Фильтр масла', 'Стандартный', 20, 'шт.', 100, 'Двигатель'),
(103, 'Амортизатор', 'Задний', 15, 'шт.', 350, 'Подвеска'),
(104, 'Топливный насос', 'Электрический', 10, 'шт.', 1200, 'Топливная система'),
(105, 'Фильтр воздуха', 'Специальный', 30, 'шт.', 200, 'Воздушная система');

INSERT INTO order_of_spare_part (id_order, code, count)
VALUES
(1, 101, 1),
(2, 102, 2),
(3, 103, 1);


SELECT
    c.number,
    MAX(o.date_of_receipt) as last_service_date,
    COUNT(op.code) as parts_replaced_count
FROM
    car c
    LEFT JOIN order_ o ON c.number = o.number
    LEFT JOIN order_of_spare_part op ON o.id_order = op.id_order
GROUP BY
    c.number;
