-- Запрос36: Выбрать госномера, названия модели и марки автомобилей одной модели и одного года выпуска, которые ремонтировались одинаковое количество раз.

-- Вставка данных для таблицы person
INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

-- Вставка данных для таблицы car
INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1), -- Ремонтировался 2 раза
('B456CD', '78', 2010, 'легковой', 'ModelX', 'Кроссовер', 'Toyota', 2), -- Ремонтировался 2 раза
('C789EF', '79', 2010, 'легковой', 'ModelX', 'Хэтчбек', 'Toyota', 1); -- Ремонтировался 1 раз

-- Вставка данных для таблицы order_
INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', NULL),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'B456CD', NULL),
(3, '2024-03-01', '2024-03-10', '2024-03-09', 4000, 'Ремонт трансмиссии', TRUE, 'A123BC', NULL),
(4, '2024-04-01', '2024-04-10', '2024-04-09', 3500, 'Замена масла', TRUE, 'B456CD', NULL);

-- Основной запрос:
WITH RepairsCount AS (
    SELECT
        c.mark, 
        c.model,
        c.year,
        c.number,
        COUNT(o.id_order) AS repairs_count
    FROM
        car c
        JOIN order_ o ON c.number = o.number
    GROUP BY
        c.model, c.year, c.number
)
SELECT
    rc.mark,
    rc.model,
    rc.number,
    rc.repairs_count
FROM
    RepairsCount rc
JOIN (
    SELECT
        model,
        year,
        repairs_count
    FROM
        RepairsCount
    GROUP BY
        model, year, repairs_count
    HAVING COUNT(*) > 1
) identical_repairs ON rc.model = identical_repairs.model
                   AND rc.year = identical_repairs.year
                   AND rc.repairs_count = identical_repairs.repairs_count
ORDER BY
    rc.repairs_count DESC;
