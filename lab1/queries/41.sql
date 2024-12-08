--Запрос41 :Выбрать название марки название модели и название запчасти которую приходится менять для данной модели чаще других .

SELECT
    c.mark,
    c.model,
    sp.name_spare_part,
    COUNT(os.count) AS replacement_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part os ON o.id_order = os.id_order
    JOIN spare_part sp ON os.code = sp.code
GROUP BY
    c.mark,
    c.model,
    sp.name_spare_part
ORDER BY
    c.mark,
    c.model,
    replacement_count DESC;
