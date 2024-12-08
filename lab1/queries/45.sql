-- Запрос 45: Выбрать фамилию, имя, отчество мастера, который чинил автомобили всех категорий (легковые и грузовые).

SELECT
    P.surname,
    P.name,
    P.patronymic
FROM
    master M
    JOIN order_ O ON M.id_master = O.id_master
    JOIN car C ON O.number = C.number
    JOIN person P ON M.id_person = P.id_person
GROUP BY
    M.id_master, P.surname, P.name, P.patronymic
HAVING
    COUNT(DISTINCT C.category) = 2;
