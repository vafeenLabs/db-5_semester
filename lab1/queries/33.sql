-- Запрос 33: Выбрать фамилии имена отчества мастеров и размер ставки.
SELECT
    surname,
    name,
    patronymic,
    work_rate
FROM
    master
    join person on person.id_person = master.id_person;