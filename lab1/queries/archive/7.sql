-- Запрос 7: Выбрать все данные о владельцах с id равным 1, 3, 5.

SELECT
    *
FROM
    person
WHERE
    id_person IN (1, 3, 5);
