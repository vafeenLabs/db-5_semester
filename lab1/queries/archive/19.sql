-- Запрос 19: Для каждого года вывести количество выпущенных автомобилей,
-- ремонтировавшихся в текущем месяце.

SELECT
    year,
    COUNT(*) AS cars_repaired_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
WHERE
    EXTRACT(MONTH FROM o.date_of_receipt) = EXTRACT(MONTH FROM CURRENT_DATE)
    AND EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    year;