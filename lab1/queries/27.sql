-- Запрос 27: Выбрать названия марок для которых не указаны модели в базе.

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '77', 2020, 'Седан', 'Toyota', 'Универсал', 'Toyota', NULL),
('C789EF', '79', 2018, 'Хэтчбек', 'Ford', 'Хэтчбек', 'Ford', NULL),
('B456DE', '78', 2021, 'Кроссовер', 'Kona', 'Кроссовер', 'Hyundai', NULL),
('D987JK', '70', 2022, 'Седан', 'Model S', 'Люксовый', 'Tesla', NULL),
('E321HJ', '71', 2021, 'Пикап', 'F-150', 'Пикап', 'Ford', NULL);



SELECT
    DISTINCT mark
FROM
    car
WHERE
    model IS NULL;
