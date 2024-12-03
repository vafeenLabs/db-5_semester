-- Запрос 17: Для каждого автомобиля выбрать количество различных запчастей, которые были заменены в текущем году.

INSERT INTO person (id_person, name, surname, patronymic, phone) VALUES
(1, 'Иван', 'Иванов', 'Иванович', '89001234567'),
(2, 'Петр', 'Петров', 'Петрович', '89007654321'),
(3, 'Анна', 'Смирнова', 'Андреевна', '89004561234');

INSERT INTO master (id_master, date_of_birth, specialization, experience, work_rate, id_person) VALUES
(1, '1980-05-15', 'Кузовной ремонт', 10, 0.5, 1),
(2, '1990-10-20', 'Электрика', 5, 0.7, 2);

INSERT INTO car (number, region, year, category, model, body_type, mark, id_person) VALUES
('A123BC', '123', 2015, 'Легковой', 'Toyota Camry', 'Седан', 'Toyota', 1),
('B456DE', '456', 2018, 'Внедорожник', 'Nissan X-Trail', 'Кроссовер', 'Nissan', 2);

INSERT INTO order_ (id_order, date_of_receipt, planned_completion, actual_completion, sum_of_cost, comment, client, number, id_master) VALUES
(1, '2024-01-15', NULL, NULL, 5000, NULL ,TRUE ,'A123BC' ,1),
(2,'2024-02-20',NULL ,NULL ,3000 ,NULL ,FALSE ,'B456DE' ,2);

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category) VALUES
(1, 'Тормозные колодки', NULL, 10, 'шт.', 1500, 'Тормозная система'),
(2, 'Масло моторное', NULL, 20, 'л.', 500, 'Масла');

INSERT INTO order_of_spare_part (id_order, code, count) VALUES
(1, 1, 2), -- Заменены тормозные колодки для A123BC
(1, 2, 1), -- Заменено масло моторное для A123BC
(2, 1, 4); -- Заменены тормозные колодки для B456DE

SELECT
    c.number,
    COUNT(DISTINCT os.code) AS parts_replaced_count
FROM
    order_of_spare_part os
    JOIN order_ o ON os.id_order = o.id_order
    JOIN car c ON o.number = c.number
WHERE
    EXTRACT(YEAR FROM o.date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY
    c.number;