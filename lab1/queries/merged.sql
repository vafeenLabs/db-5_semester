-- Запрос 28: Выбрать госномер автомобиля,
-- дату последнего обращения и если были замены запчастей то их количество.

SELECT
    c.number,
    MAX(o.date_of_receipt) as last_service_date,
    COUNT(op.code) as parts_replaced_count
FROM
    car c
    LEFT JOIN order_ o ON c.number = o.number
    LEFT JOIN order_of_spare_part op ON o.id_order = op.id_order
GROUP BY
    c.number;


-- Таск: Запрос 29: Выбрать госномер автомобиля,
-- дату последнего обращения и если были замены запчастей, то наименования запчастей.

SELECT
    c.number,
    MAX(o.date_of_receipt) as last_service_date,
    STRING_AGG(sp.name_spare_part, ', ') as replaced_parts_names
FROM
    car c
    LEFT JOIN order_ o ON c.number = o.number
    LEFT JOIN order_of_spare_part op ON o.id_order = op.id_order
    LEFT JOIN spare_part sp ON op.code = sp.code
GROUP BY
    c.number;

-- STRING_AGG(sp.name_spare_part, ', ') — объединяет все названия запчастей в одну строку, разделяя их запятыми и пробелами.
