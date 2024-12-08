-- Запрос 4: Выбрать id запчастей, для которых не определена категория.

SELECT
    code
FROM
    spare_part
WHERE
    category IS NULL;
