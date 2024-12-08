-- 50. Выбрать тройку самых старых автомобилей.

SELECT
    number,
    mark,
    model,
    year
FROM
    car
ORDER BY
    year ASC
LIMIT
    3;
