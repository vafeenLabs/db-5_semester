-- 49. Вывести фамилии, имена, отчества владельцев, которые обладают 2 автомобилями и более, но не имеют однофамильцев или тезок.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Сидоров', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234'),
(4, 'Сергей', 'Иванов', 'Петрович', '89005551234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2020, 'Седан', 'Toyota', 'Легковой', 'Corolla', 1),
('012JKL', '80', 2022, 'Пикап', 'Chevrolet', 'Коммерческий', 'Colorado', 1),
('456DEF', '78', 2019, 'Универсал', 'Ford', 'Коммерческий', 'Focus', 2),
('789GHI', '79', 2021, 'Кроссовер', 'Nissan', 'Легковой', 'Qashqai', 3);

SELECT
    p.surname,
    p.name,
    p.patronymic
FROM
    person p
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            car
        WHERE
            car.id_person = p.id_person
    ) >= 2
    AND NOT EXISTS (
        SELECT
            1
        FROM
            person p2
        WHERE
            (p2.surname = p.surname
            OR p2.name = p.name)
            AND p2.id_person != p.id_person
    );
