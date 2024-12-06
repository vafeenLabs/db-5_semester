---Запрос46 :Выбрать фамилии имена отчества владельцев транспортных средств двух разных категорий которые имеют два автомобиля одной марки .

INSERT INTO person (id_person, name, surname, patronymic, phone)
VALUES
(1, 'Иван', 'Иванов', 'Иванович', '1234567890'),
(2, 'Петр', 'Петров', 'Петрович', '0987654321'),
(3, 'Алексей', 'Алексеев', 'Алексеевич', '1122334455');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person)
VALUES
('A123BC', '77', 2010, 'Седан', 'ModelX', 'Седан', 'Toyota', 1),
('B456CD', '78', 2015, 'Кроссовер', 'ModelY', 'Кроссовер', 'Toyota', 1),
('C789EF', '79', 2018, 'Минивэн', 'ModelZ', 'Минивэн', 'Honda', 2),
('D012GH', '80', 2020, 'Седан', 'ModelA', 'Седан', 'Toyota', 3),
('E345IJ', '81', 2021, 'Кроссовер', 'ModelB', 'Кроссовер', 'Toyota', 3);

SELECT
    DISTINCT p.surname,
    p.name,
    p.patronymic
FROM
    person p
    JOIN car c1 ON p.id_person = c1.id_person
    JOIN car c2 ON p.id_person = c2.id_person
WHERE
    c1.mark = c2.mark
    AND c1.category <> c2.category
GROUP BY
    p.id_person
HAVING
    COUNT(DISTINCT c1.category) = 2;

