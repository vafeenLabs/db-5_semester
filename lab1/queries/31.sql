-- Таск: Запрос 31: Выбрать номер автомобиля, которому каждый раз делают замену одной и той же запчасти.

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', NULL),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', NULL),
('B456DE', '78', 2021, 'Кроссовер', 'Kona', 'Кроссовер', 'Hyundai', NULL);

INSERT INTO order_ (id_order, number, date_of_receipt) VALUES
(1, 'A123BC', '2023-01-15'),
(2, 'A123BC', '2023-03-20'),
(3, 'C789EF', '2023-06-10'),
(4, 'C789EF', '2023-09-05');

INSERT INTO spare_part (code, name_spare_part, category) VALUES
(101, 'Фильтр масляный', 'Двигатель'),
(102, 'Свечи зажигания', 'Двигатель'),
(103, 'Тормозные колодки', 'Тормоза');

INSERT INTO order_of_spare_part (id_order, code) VALUES
(1, 101), -- A123BC
(2, 101), -- A123BC
(3, 101), -- C789EF
(4, 102); -- C789EF

SELECT
    o.number,
    sp.code,
    sp.name_spare_part,
    COUNT(op.id_order) AS replacement_count
FROM
    order_of_spare_part op
    JOIN order_ o ON op.id_order = o.id_order
    JOIN spare_part sp ON op.code = sp.code
GROUP BY
    o.number,
    sp.code,
    sp.name_spare_part
HAVING
    COUNT(op.id_order) = (
        SELECT
            COUNT(*)
        FROM
            order_of_spare_part sub_op
            JOIN order_ sub_o ON sub_op.id_order = sub_o.id_order
        WHERE
            sub_o.number = o.number
    )
    AND COUNT(op.id_order) > 1;
