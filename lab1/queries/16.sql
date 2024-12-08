-- Запрос 16: Для каждого владельца вывести год его самого старого автомобиля.

SELECT
    id_person AS owner_id,
    MIN(year) AS oldest_car_year
FROM
    car
GROUP BY
    id_person;