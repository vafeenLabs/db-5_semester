-- Запрос 8: Выбрать все данные об автомобилях, в номерах которых есть "123".

SELECT
    *
FROM
    car
WHERE
    number LIKE '%123%';

-- %123% означает, что поле number должно содержать последовательность символов 123 в любом месте: