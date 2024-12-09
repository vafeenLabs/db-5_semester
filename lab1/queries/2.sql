-- 2. Выбрать фамилию и инициалы (через точку), телефон мастеров. 
-- Результат отсортировать по фамилии в лексикографическом порядке.

SELECT
    p.surname || ' ' || LEFT(p.name, 1) || '.' || LEFT(p.patronymic, 1) || '.' AS master_info,
    p.phone
FROM
    master m
    JOIN person p ON m.id_person = p.id_person
ORDER BY
    p.surname;