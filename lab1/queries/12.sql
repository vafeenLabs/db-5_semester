-- Запрос 12: Выбрать количество различных поставщиков с опоздавшими заказами.

SELECT
    COUNT(DISTINCT p.id_provider)
FROM
    provider p
    JOIN order_ o ON p.id_provider = o.id_provider
WHERE
    o.actual_completion > o.planned_completion;