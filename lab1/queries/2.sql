-- 2. Выбрать фамилию и инициалы (через точку), телефон мастеров. Результат отсортировать по фамилии в лексикографическом порядке.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2),
(3, '1985-07-10', 'Диагностика', 8, 0.6, 3);

SELECT
    p.surname || ' ' || LEFT(p.name, 1) || '.' || LEFT(p.patronymic, 1) || '.' AS master_info,
    p.phone
FROM
    master m
    JOIN person p ON m.id_person = p.id_person
ORDER BY
    p.surname;