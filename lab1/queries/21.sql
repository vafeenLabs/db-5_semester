-- Запрос 21: Вывести фамилию, имя, отчество владельца,
-- номер автомобиля и количество ремонтов за прошлый год.

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.number,
    COUNT(o.id_order) AS repairs_count
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
    JOIN order_ o ON c.number = o.number
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY
    p.surname,
    p.name,
    p.patronymic,
    c.number;

-- EXTRACT(YEAR FROM CURRENT_DATE) используется для извлечения года из текущей даты.
-- CURRENT_DATE — возвращает текущую дату (системную) без времени.
-- Например: 2024-12-11.
-- EXTRACT(YEAR FROM ...) — извлекает только год из указанной даты