-- Запрос 20: Выбрать фамилии, имена, отчества мастеров,
-- которые выполнили не более пяти заказов.

SELECT
    p.surname,
    p.name,
    p.patronymic,
    COUNT(o.id_order) AS orders_count
FROM
    master m
    LEFT JOIN person p ON m.id_person = p.id_person 
    LEFT JOIN order_ o ON m.id_master = o.id_master 
GROUP BY
    m.id_master,
    p.surname,
    p.name,
    p.patronymic
HAVING
    COUNT(o.id_order) <= 5;
