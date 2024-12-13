-- Таск: Запрос 31: Выбрать номер автомобиля, которому каждый раз делают замену одной и той же запчасти.

SELECT
    o.number,
    sp.code,
    sp.name_spare_part,
    COUNT(op.id_order) AS replacement_count
FROM
    order_of_spare_part op
    JOIN order_ o ON op.id_order = o.id_order
    JOIN spare_part sp ON op.code = sp.code
GROUP BY
    o.number,
    sp.code,
    sp.name_spare_part
HAVING
    COUNT(op.id_order) = (
        SELECT
            COUNT(*)
        FROM
            order_of_spare_part sub_op
            JOIN order_ sub_o ON sub_op.id_order = sub_o.id_order
        WHERE
            sub_o.number = o.number
    )
