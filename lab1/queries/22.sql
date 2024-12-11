-- Запрос 22: Для каждого мастера вывести количество ремонтов, выполненных по трем последним годам.

SELECT
    m.id_master,
    p.surname,
    p.name,
    p.patronymic,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1 THEN o.id_order
        END
    ) AS last_year_count,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 2 THEN o.id_order
        END
    ) AS two_years_ago_count,
    COUNT(
        CASE
            WHEN EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 3 THEN o.id_order
        END
    ) AS three_years_ago_count
FROM
    master m
    LEFT JOIN person p ON m.id_person = p.id_person
    LEFT JOIN order_ o ON m.id_master = o.id_master
GROUP BY
    m.id_master, p.surname, p.name, p.patronymic;

/*
EXTRACT(YEAR FROM o.date_of_receipt)
Извлекается год из даты заказа (date_of_receipt).

EXTRACT(YEAR FROM CURRENT_DATE) - N
Вычисляется год, отстоящий от текущего года на N лет назад:

CURRENT_DATE - 1 — предыдущий год.
CURRENT_DATE - 2 — два года назад.
CURRENT_DATE - 3 — три года назад.
CASE ... WHEN ... THEN ... END

Проверяется, совпадает ли год из o.date_of_receipt с одним из указанных годов.
Если совпадает, возвращается идентификатор заказа (o.id_order).
Если не совпадает, возвращается NULL.
COUNT(CASE ... END)
Считается количество строк, где результат CASE не равен NULL, то есть количество заказов за указанный год.
*/