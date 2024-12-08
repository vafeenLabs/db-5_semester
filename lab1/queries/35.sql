-- Запрос35 :Выбрать фамилию имя отчество владельца двух автомобилей одной модели .

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.model
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
GROUP BY
    p.surname,
    p.name,
    p.patronymic,
    c.model
HAVING
    COUNT(c.number) = 2;
