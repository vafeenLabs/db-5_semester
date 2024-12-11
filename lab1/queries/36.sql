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

-- Это временная таблица, которая подсчитывает количество ремонтов для каждого автомобиля. Для этого:
-- JOIN соединяет таблицы car (автомобили) и order_ (заказы) по номеру автомобиля (c.number = o.number).
-- COUNT(o.id_order) подсчитывает количество заказов (ремонтов) для каждого автомобиля.
-- GROUP BY группирует записи по модели, году и номеру автомобиля, чтобы подсчитать количество ремонтов для каждой комбинации.
-- Результат этого CTE — таблица, где для каждого автомобиля указаны марка, модель, год выпуска, номер и количество ремонтов.


-- Основной запрос выбирает автомобили, которые ремонтировались одинаковое количество раз.
-- JOIN соединяет таблицу RepairsCount с подзапросом, который выбирает модели и года автомобилей с одинаковым количеством ремонтов.
-- В подзапросе:
-- GROUP BY группирует автомобили по модели, году и количеству ремонтов.
-- HAVING COUNT(*) > 1 фильтрует только те группы, где есть больше одного автомобиля с одинаковым количеством ремонтов. 
-- Это означает, что выбираются только те модели и годы, где несколько автомобилей ремонтировались одинаковое количество раз.
-- JOIN в основном запросе связывает автомобили из RepairsCount с этими группами одинаковых 
-- ремонтов по модели, году и количеству ремонтов.