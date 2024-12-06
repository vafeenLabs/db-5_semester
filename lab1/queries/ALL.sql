

-- Запрос 32: Для каждого поставщика вывести названия категорий запчастей,
-- которые он не поставляет.
SELECT
    p.name_provider,
    sp.category
FROM
    provider p
    CROSS JOIN spare_part sp
    LEFT JOIN order_of_spare_part op ON sp.code = op.code
WHERE
    op.id_order IS NULL;

