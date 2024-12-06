-- 50. Выбрать тройку самых старых автомобилей.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '77', 2020, 'Седан', 'Toyota', 'Легковой', 'Corolla', 1),
('456DEF', '78', 2019, 'Универсал', 'Ford', 'Коммерческий', 'Focus', 2),
('789GHI', '79', 2021, 'Кроссовер', 'Nissan', 'Легковой', 'Qashqai', 3),
('012JKL', '80', 2022, 'Пикап', 'Chevrolet', 'Коммерческий', 'Colorado', 1);

SELECT
    number,
    mark,
    model,
    year
FROM
    car
ORDER BY
    year ASC
LIMIT
    3;
