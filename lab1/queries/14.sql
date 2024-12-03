-- Запрос 14: Выбрать название марки, модели, госномер всех автомобилей.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('B456DE', '456', 2018, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2),
('C789FG', '789', 2020, 'Грузовой', 'Mercedes-Benz Actros', 'Шасси', 'Mercedes-Benz', 3),
('D012HI', '012', 2019, 'Легковой', 'Honda Accord', 'Седан', 'Honda', 1);

SELECT
    mark,
    model,
    number
FROM
    car;