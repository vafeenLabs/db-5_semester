-- Запрос 8: Выбрать все данные об автомобилях, в номерах которых есть "123".

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('123ABC', '123', 2020, 'Sedan', 'Toyota', 'Sedan', 'Toyota', 1),
('XYZ123', '124', 2021, 'Coupe', 'Honda', 'Coupe', 'Honda', 2),
('AAA123', '125', 2022, 'Hatchback', 'Ford', 'Hatchback', 'Ford', 3),
('123XYZ', '126', 2023, 'SUV', 'Nissan', 'SUV', 'Nissan', 4);

SELECT
    *
FROM
    car
WHERE
    number LIKE '%123%';
