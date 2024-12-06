-- Запрос 33: Выбрать фамилии имена отчества мастеров и размер ставки.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Сидоров', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234'),
(4, 'Сергей', 'Иванов', 'Петрович', '89005551234');

INSERT INTO master (id_master, specialization, experience, work_rate, id_person) VALUES
(1, 'Автослесарь', 5, 1, 1),
(2, 'Механик', 3, 0.7, 2),
(3, 'Электрик', 6, 0.5, 3),
(4, 'Диагност', 4, 2.5, 4);



SELECT
    surname,
    name,
    patronymic,
    work_rate
FROM
    master join person using(id_person);