-- 23. Вывести название запчастей, которые были заменены как минимум на трех машинах марки Хонда.
SELECT
    sp.name_spare_part,
    COUNT(DISTINCT c.number)
FROM
    spare_part sp
    JOIN order_of_spare_part osp ON sp.code = osp.code
    JOIN order_ o ON osp.id_order = o.id_order
    JOIN car c ON o.number = c.number
WHERE
    c.mark = 'Honda'
GROUP BY
    sp.name_spare_part
HAVING
    COUNT(DISTINCT c.number) >= 3;

-- Ничего не выведет, лучше < 3