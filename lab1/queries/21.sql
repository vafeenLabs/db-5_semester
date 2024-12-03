-- Запрос 21: Вывести фамилию, имя, отчество владельца,
-- номер автомобиля и количество ремонтов за прошлый год.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234'),
(4, 'Мария', 'Кузнецова', 'Игоревна', '89005432167');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2021, 'Седан', 'Toyota', 'Купе', 'Corolla', 1),
('XYZ123', '77', 2020, 'Хэтчбек', 'Honda', 'Седан', 'Civic', 2),
('AAA123', '77', 2019, 'Универсал', 'Mazda', 'Пикап', 'Mazda 3', 3),
('123XYZ', '77', 2022, 'Кроссовер', 'Nissan', 'Минивэн', 'Qashqai', 4);

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2),
(3, '1985-07-10', 'Диагностика', 8, 0.6, 3),
(4, '1988-03-12', 'Механика', 7, 0.9, 4);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2023-01-15', '2023-01-20', '2023-01-18', 5000, 'Замена масла', TRUE, '123ABC', 1),
(2, '2023-06-15', '2023-06-20', '2023-06-18', 3000, 'Ремонт подвески', TRUE, 'XYZ123', 2),
(3, '2023-09-05', '2023-09-15', '2023-09-12', 7000, 'Ремонт двигателя', TRUE, 'XYZ123', 3),
(4, '2023-11-25', '2023-12-05', '2023-12-02', 6000, 'Покраска кузова', TRUE, '123XYZ', 4),
(5, '2024-03-01', '2024-03-10', '2024-03-09', 5500, 'Замена колодок', TRUE, '123ABC', 1);

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.number,
    COUNT(o.id_order) AS repairs_count
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
    JOIN order_ o ON c.number = o.number
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY
    p.surname,
    p.name,
    p.patronymic,
    c.number;
