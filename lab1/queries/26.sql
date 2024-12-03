-- Запрос 26: Выбрать названия всех марок и если есть то названия моделей.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '12345678901'),
(2, 'Петр', 'Петров', 'Петрович', '12345678902'),
(3, 'Сергей', 'Сергеев', 'Сергеевич', '12345678903');

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', 1),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', 1),
('B456GF', '78', 2021, 'Кроссовер', 'Kona', 'Кроссовер', 'Hyundai', 2),
('D987JK', '70', 2022, 'Седан', 'Model S', 'Люксовый', 'Tesla', 3),
('E321HJ', '71', 2021, 'Пикап', 'F-150', 'Пикап', 'Ford', 2);

SELECT
    DISTINCT mark,
    model
FROM
    car;
