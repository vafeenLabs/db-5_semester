--- 47. Выбрать названия запчастей, которые устанавливались на самые старые автомобили.

SELECT
    sp.name_spare_part
FROM
    order_of_spare_part oos
    JOIN order_ o ON oos.id_order = o.id_order
    JOIN car c ON o.number = c.number
    JOIN spare_part sp ON oos.code = sp.code
WHERE
    c.year = (
        SELECT
            MIN(year)
        FROM
            car
    );
