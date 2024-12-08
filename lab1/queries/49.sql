-- 49. Вывести фамилии, имена, отчества владельцев, которые обладают 2 автомобилями и более, но не имеют однофамильцев или тезок.

SELECT
    p.surname,
    p.name,
    p.patronymic
FROM
    person p
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            car
        WHERE
            car.id_person = p.id_person
    ) >= 2
    AND NOT EXISTS (
        SELECT
            1
        FROM
            person p2
        WHERE
            (p2.surname = p.surname
            OR p2.name = p.name)
            AND p2.id_person != p.id_person
    );
