-- Запрос 5: Выбрать заглавными буквами фамилии, имена, отчества мастеров, работающих менее чем на 0,7 ставки.

SELECT
    UPPER(p.surname),
    UPPER(p.name),
    UPPER(p.patronymic)
FROM
    master m
JOIN
    person p ON m.id_person = p.id_person
WHERE
    m.work_rate < 0.7;
