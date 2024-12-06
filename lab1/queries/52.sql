-- 52. Выбрать названия поставщиков, количество заказов в прошлом году, процентное отношение ко всем заказам прошлого года.

INSERT INTO provider (id_provider, name_provider, adress, name_manager, surname_manager, patronymic_manager, phone_manager) VALUES
(1, 'Поставщик А', 'Улица А, 1', 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Поставщик Б', 'Улица Б, 2', 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Поставщик В', 'Улица В, 3', 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2023-03-15', '2023-03-20', '2023-03-19', 5000, 'Комментарий 1', TRUE, NULL, NULL),
(2, '2023-06-10', '2023-06-15', '2023-06-14', 7000, 'Комментарий 2', TRUE, NULL, NULL),
(3, '2023-12-01', '2023-12-05', '2023-12-05', 10000, 'Комментарий 3', TRUE, NULL, NULL),
(4, '2024-01-10', '2024-01-15', '2024-01-15', 15000, 'Комментарий 4', TRUE, NULL, NULL);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(101, 'Деталь 1', NULL, 10, 'шт', 1000, 'Категория А'),
(102, 'Деталь 2', NULL, 5, 'шт', 2000, 'Категория Б'),
(103, 'Деталь 3', NULL, 8, 'шт', 3000, 'Категория В'),
(104, 'Деталь 4', NULL, 12, 'шт', 4000, 'Категория Г');


INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 101, 5),
(2, 102, 2),
(3, 103, 7),
(4, 104, 3);


SELECT
    p.name_provider,
    COUNT(o.id_order) AS total_orders,
    ROUND(
        COUNT(o.id_order) * 100.0 / (
            SELECT
                COUNT(*)
            FROM
                order_ o
            WHERE
                o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year'
                AND o.date_of_receipt < date_trunc('year', current_date)
        ),
        2
    ) AS percentage
FROM
    provider p
    LEFT JOIN order_of_spare_part oos ON p.id_provider = oos.id_order
    LEFT JOIN order_ o ON oos.id_order = o.id_order
WHERE
    o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year'
    AND o.date_of_receipt < date_trunc('year', current_date)
GROUP BY
    p.name_provider;
