-- Запрос 44: Выбрать автомобиль, на котором ни одну запчасть не меняли дважды.

SELECT
    O.number
FROM
    order_ O
    JOIN order_of_spare_part OP ON O.id_order = OP.id_order
GROUP BY
    O.number
HAVING
    COUNT(OP.code) = COUNT(DISTINCT OP.code);
