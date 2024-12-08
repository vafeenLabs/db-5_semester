-- Запрос 27: Выбрать названия марок для которых не указаны модели в базе.

SELECT
    DISTINCT mark
FROM
    car
WHERE
    model IS NULL;
