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
