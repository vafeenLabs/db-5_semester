-- Запрос35 :Выбрать фамилию имя отчество владельца двух автомобилей одной модели .
INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '23456789012');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'легковой', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2012, 'легковой', 'ModelX', 'Кроссовер', 'Toyota', 1),
('C789EF', '79', 2015, 'легковой', 'ModelY', 'Хэтчбек', 'Honda', 2);

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.model
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
GROUP BY
    p.surname,
    p.name,
    p.patronymic,
    c.model
HAVING
    COUNT(c.number) = 2;
