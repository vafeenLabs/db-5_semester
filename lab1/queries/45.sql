-- Запрос 45: Выбрать фамилию, имя, отчество мастера, который чинил автомобили всех категорий (легковые и грузовые).

INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012'),
(3, 'Сергей', 'Сергеев', 'Сергеевич', '34567890123'),
(4, 'Дмитрий', 'Дмитриев', 'Дмитриевич', '45678901234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'легковой', 'ModelY', 'Кроссовер', 'Toyota', 1),
('C789EF', '79', 2018, 'легковой', 'ModelZ', 'Минивэн', 'Honda', 2),
('D012GH', '80', 2020, 'легковой', 'ModelA', 'Седан', 'Toyota', 3),
('E345IJ', '81', 2021, 'грузовой', 'ModelB', 'Пикап', 'Ford', 4),
('F678KL', '82', 2022, 'грузовой', 'ModelC', 'Кабриолет', 'BMW', 4);

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person)
VALUES
(1, '1985-01-01', 'Автослесарь', 10, 4.5, 1),
(2, '1990-02-02', 'Механик', 8, 4.2, 2),
(3, '1980-03-03', 'Автослесарь', 12, 4.8, 3),
(4, '1975-04-04', 'Техник', 15, 5.0, 4);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master)
VALUES
(1, '2024-01-01', '2024-01-10', '2024-01-09', 5000, 'Ремонт двигателя', TRUE, 'A123BC', 1),
(2, '2024-02-01', '2024-02-15', '2024-02-14', 3000, 'Замена тормозов', TRUE, 'F678KL', 1),
(3, '2024-03-01', '2024-03-10', '2024-03-09', 7000, 'Ремонт трансмиссии', TRUE, 'C789EF', 2),
(4, '2024-04-01', '2024-04-10', '2024-04-09', 8000, 'Ремонт подвески', TRUE, 'D012GH', 3),
(5, '2024-05-01', '2024-05-10', '2024-05-09', 10000, 'Ремонт двигателя', TRUE, 'E345IJ', 4),
(6, '2024-06-01', '2024-06-10', '2024-06-09', 12000, 'Ремонт трансмиссии', TRUE, 'F678KL', 4);

-- Основной запрос:
SELECT
    P.surname,
    P.name,
    P.patronymic
FROM
    master M
    JOIN order_ O ON M.id_master = O.id_master
    JOIN car C ON O.number = C.number
    JOIN person P ON M.id_person = P.id_person
GROUP BY
    M.id_master, P.surname, P.name, P.patronymic
HAVING
    COUNT(DISTINCT C.category) = 2;
