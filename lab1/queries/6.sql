-- Запрос 6: Выбрать номера автомобилей, выпущенных с 2020 года по текущий год.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2021, 'Sedan', 'Toyota', 'Sedan', 'Corolla', 1),
('B456CD', '78', 2022, 'SUV', 'Honda', 'SUV', 'CR-V', 2),
('C789EF', '79', 2023, 'Hatchback', 'Ford', 'Hatchback', 'Fiesta', 3);

SELECT
    number
FROM
    car
WHERE
    year >= 2020;
