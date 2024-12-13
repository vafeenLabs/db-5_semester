--Запрос40 :Выбрать фамилию имя отчество владельца госномер автомобиля на который был сделан самый дорогой заказ .

SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.number
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
    JOIN order_ o ON c.number = o.number
ORDER BY
    sum_of_cost DESC
LIMIT
    (1);