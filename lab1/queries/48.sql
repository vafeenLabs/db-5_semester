-- 48. Выбрать марку, модель, госномер автомобилей, на которых делали замену, как самой дорогой, так и самой дешевой запчасти.

WITH max_min_spare_parts AS (
    SELECT 
        MAX(sp.cost) AS max_cost, 
        MIN(sp.cost) AS min_cost
    FROM 
        spare_part sp
)
SELECT 
    c.mark, 
    c.model, 
    c.number,
    MAX(sp.cost) AS expensive_cost,
    MIN(sp.cost) AS cheap_cost,
    (SELECT name_spare_part 
     FROM spare_part sp2
     WHERE sp2.cost = MAX(sp.cost)
     LIMIT 1) AS expensive_spare_part,
    (SELECT name_spare_part 
     FROM spare_part sp2
     WHERE sp2.cost = MIN(sp.cost)
     LIMIT 1) AS cheap_spare_part
FROM 
    car c
JOIN 
    order_ o ON c.number = o.number
JOIN 
    order_of_spare_part o_sp ON o.id_order = o_sp.id_order
JOIN 
    spare_part sp ON o_sp.code = sp.code
JOIN
    max_min_spare_parts mmsp ON sp.cost = mmsp.max_cost OR sp.cost = mmsp.min_cost
GROUP BY 
    c.number, c.mark, c.model
HAVING
    MAX(sp.cost) = (SELECT max_cost FROM max_min_spare_parts)
    AND MIN(sp.cost) = (SELECT min_cost FROM max_min_spare_parts);
