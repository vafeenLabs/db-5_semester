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
