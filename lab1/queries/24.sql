-- Запрос 24: Выбрать названия неисправностей, которые устраняет только один мастер.
SELECT
    m.name_malfunction
FROM
    malfunction m
WHERE
    m.id_malfunction IN (
        SELECT
            om.id_malfunction
        FROM
            order_malfunction om
            JOIN order_ o ON o.id_order = om.id_order
            JOIN master ma ON ma.id_master = o.id_master
        GROUP BY
            om.id_malfunction
        HAVING
            COUNT(DISTINCT ma.id_master) = 1
    );