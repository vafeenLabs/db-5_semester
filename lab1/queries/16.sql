-- Запрос 16: Для каждого владельца вывести год его самого старого автомобиля.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('D012HI', '012', 2005, 'Легковой', 'Honda Accord', 'Седан', 'Honda', 1),
('B456DE', '456', 2010, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2),
('E345JK', '345', 2012, 'Легковой', 'Ford Focus', 'Хэтчбек', 'Ford', 2),
('C789FG', '789', 2018, 'Грузовой', 'Mercedes-Benz Actros', 'Шасси', 'Mercedes-Benz', 3);

SELECT
    id_person AS owner_id,
    MIN(year) AS oldest_car_year
FROM
    car
GROUP BY
    id_person;