-- Запрос 26: Выбрать названия всех марок и если есть то названия моделей.

SELECT
    DISTINCT mark,
    model
FROM
    car;
