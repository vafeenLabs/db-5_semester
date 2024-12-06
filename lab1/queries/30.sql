-- Запрос 30: Выбрать название марки и название моделей,
-- автомобили которых не представлены в БД.
SELECT
    DISTINCT mark,
    model
FROM
    car
WHERE
    model NOT IN (
        SELECT
            DISTINCT model
        from
            car
    );