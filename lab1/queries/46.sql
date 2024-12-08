---Запрос46 :Выбрать фамилии имена отчества владельцев транспортных средств двух разных категорий которые имеют два автомобиля одной марки .

SELECT
    DISTINCT p.surname,
    p.name,
    p.patronymic
FROM
    person p
    JOIN car c1 ON p.id_person = c1.id_person
    JOIN car c2 ON p.id_person = c2.id_person
WHERE
    c1.mark = c2.mark
    AND c1.category <> c2.category
GROUP BY
    p.id_person
HAVING
    COUNT(DISTINCT c1.category) = 2;

