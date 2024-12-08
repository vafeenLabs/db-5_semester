-- Запрос36: Выбрать госномера, названия модели и марки автомобилей одной модели и одного года выпуска, которые ремонтировались одинаковое количество раз.

WITH RepairsCount AS (
    SELECT
        c.mark, 
        c.model,
        c.year,
        c.number,
        COUNT(o.id_order) AS repairs_count
    FROM
        car c
        JOIN order_ o ON c.number = o.number
    GROUP BY
        c.model, c.year, c.number
)
SELECT
    rc.mark,
    rc.model,
    rc.number,
    rc.repairs_count
FROM
    RepairsCount rc
JOIN (
    SELECT
        model,
        year,
        repairs_count
    FROM
        RepairsCount
    GROUP BY
        model, year, repairs_count
    HAVING COUNT(*) > 1
) identical_repairs ON rc.model = identical_repairs.model
                   AND rc.year = identical_repairs.year
                   AND rc.repairs_count = identical_repairs.repairs_count
ORDER BY
    rc.repairs_count DESC;
