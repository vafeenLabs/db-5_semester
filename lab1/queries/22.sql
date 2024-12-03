-- Запрос 22: Для каждого мастера вывести количество ремонтов, выполненных по трем последним годам.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2021, 'Седан', 'Toyota', 'Купе', 'Corolla', 1),
('XYZ123', '77', 2020, 'Хэтчбек', 'Honda', 'Седан', 'Civic', 2);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2022-05-10', '2022-05-15', '2022-05-14', 8000, 'Замена тормозных дисков', TRUE, '123ABC', 1),
(2, '2023-03-01', '2023-03-05', '2023-03-03', 5000, 'Ремонт подвески', TRUE, '123ABC', 1),
(3, '2021-07-20', '2021-07-25', '2021-07-24', 10000, 'Ремонт двигателя', TRUE, 'XYZ123', 2),
(4, '2023-06-15', '2023-06-20', '2023-06-19', 7000, 'Замена сцепления', TRUE, 'XYZ123', 2);

SELECT
    m.id_master,
    p.surname,
    p.name,
    p.patronymic,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1 THEN o.id_order
        END
    ) AS last_year_count,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 2 THEN o.id_order
        END
    ) AS two_years_ago_count,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 3 THEN o.id_order
        END
    ) AS three_years_ago_count
FROM
    master m
    LEFT JOIN person p ON m.id_person = p.id_person
    LEFT JOIN order_ o ON m.id_master = o.id_master
GROUP BY
    m.id_master, p.surname, p.name, p.patronymic;
