-- 51. Выбрать все даты прошлого месяца, в которые не осуществляли замену запчастей.

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(101, 'Деталь 1', NULL, 10, 'шт', 1000, 'Категория А'),
(102, 'Деталь 2', NULL, 5, 'шт', 2000, 'Категория Б');

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-11-01', '2024-11-05', '2024-11-05', 5000, 'Комментарий 1', TRUE, NULL, NULL),
(2, '2024-11-15', '2024-11-20', '2024-11-19', 7000, 'Комментарий 2', TRUE, NULL, NULL),
(3, '2024-11-20', '2024-11-25', '2024-11-25', 10000, 'Комментарий 3', TRUE, NULL, NULL),
(4, '2024-11-25', '2024-11-30', '2024-11-29', 15000, 'Комментарий 4', TRUE, NULL, NULL);

INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(2, 101, 3),
(4, 102, 5);

SELECT
    DISTINCT o.date_of_receipt
FROM
    order_ o
WHERE
    o.date_of_receipt >= date_trunc('month', current_date) - INTERVAL '1 month'
    AND o.date_of_receipt < date_trunc('month', current_date)
    AND NOT EXISTS (
        SELECT
            1
        FROM
            order_of_spare_part oos
        WHERE
            oos.id_order = o.id_order
    );
