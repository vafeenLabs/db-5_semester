
-- Запрос 26: Выбрать названия всех марок и если есть то названия моделей.
SELECT
    DISTINCT mark,
    model
FROM
    car;

-- Запрос 27: Выбрать названия марок для которых не указаны модели в базе.
SELECT
    DISTINCT mark
FROM
    car
WHERE
    model IS NULL;

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

-- Запрос 29: Выбрать госномер автомобиля,
-- дату последнего обращения и если были замены запчастей то наименования запчастей.
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

-- Запрос 30: Выбрать название марки и название моделей,
-- автомобили которых не представлены в БД.
SELECT
    DISTINCT mark,
    model
FROM
    car
WHERE
    model NOT IN (
        SELECT
            DISTINCT model
        from
            car
    );

-- Запрос 31: Выбрать номер автомобиля которому каждый раз делают замену одной и той же запчасти.
SELECT
    number,
    code,
    COUNT(*) as replacement_count
FROM
    order_of_spare_part
GROUP BY
    number,
    code
HAVING
    COUNT(DISTINCT id_order) > 1;

-- Запрос 32: Для каждого поставщика вывести названия категорий запчастей,
-- которые он не поставляет.
SELECT
    p.name_provider,
    sp.category
FROM
    provider p
    CROSS JOIN spare_part sp
    LEFT JOIN order_of_spare_part op ON sp.code = op.code
WHERE
    op.id_order IS NULL;

-- Запрос 33: Выбрать фамилии имена отчества мастеров и размер ставки.
SELECT
    m.surname,
    m.name,
    m.patronymic,
    m.work_rate
FROM
    master m
ORDER BY
    CASE
        WHEN NOT EXISTS (
            SELECT
                *
            from
                order_
            WHERE
                id_master = m.id_master
                AND EXTRACT(
                    MONTH
                    from
                        date
                ) = EXTRACT(
                    MONTH
                    from
                        CURRENT_DATE
                )
        ) THEN 0
        ELSE COUNT(o.id_order)
    END DESC;

-- Запрос 34: Для каждого поставщика выбрать названия всех категорий запчастей
-- и количество различных запчастей им поставляемых. Если поставщик не поставляет запчасти какой-то категории вывести ноль. Результат отсортировать по id поставщика и по названию категории.
SELECT
    p.name_provider,
    COALESCE(sp.category, 'Unknown') as category_name,
    COUNT(sp.code) as parts_count
FROM
    provider p
    LEFT JOIN spare_part sp ON p.name_provider = sp.category
GROUP BY
    p.name_provider,
    category_name
ORDER BY
    p.name_provider,
    category_name;

-- Запрос35 :Выбрать фамилию имя отчество владельца двух автомобилей одной модели .
SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.model
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
GROUP BY
    p.surname,
    p.name,
    p.patronymic,
    c.model
HAVING
    COUNT(c.number) = 2;

-- Запрос36 :Выбрать госномера названия модели и марки автомобилей одной модели
-- и одного года выпуска которые ремонтировались одинаковое количество раз .
SELECT
    c.mark,
    c.model,
    c.number,
    COUNT(o.id_order) AS repairs_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
GROUP BY
    c.mark,
    c.model,
    c.number
HAVING
    COUNT(o.id_order) = ALL (
        SELECT
            COUNT(o2.id_order)
        FROM
            car c2
            JOIN order_ o2 ON c2.number = o2.number
        WHERE
            c2.model = c.model
            AND c2.year = c.year
        GROUP BY
            c2.model,
            c2.year
    );

--Запрос37 :Выбрать название марки и модели автомобиля который ремонтировался чаще других .
SELECT
    mark,
    model,
    COUNT(o.id_order) AS repairs_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
GROUP BY
    mark,
    model
ORDER BY
    repairs_count DESC
LIMIT
    (1);

--Запрос38 :Выбрать все данные об автомобилях для которых не производились замены запчастей .
SELECT
    *
FROM
    car
WHERE
    number NOT IN (
        SELECT
            DISTINCT number
        FROM
            order_
            INNER JOIN order_of_spare_part ON id_order = id_order
    );

--Запрос39 :Выбрать все данные о заказе с самым продолжительным сроком исполнения .
SELECT
    *
FROM
    order_
ORDER BY
    planned_completion - date_of_receipt DESC
LIMIT
    (1);

--Запрос40 :Выбрать фамилию имя отчество владельца госномер автомобиля на который был сделан самый дорогой заказ .
SELECT
    p.surname,
    p.name,
    p.patronymic,
    c.number
FROM
    person p
    JOIN car c ON p.id_person = c.id_person
    JOIN order_ o ON c.number = o.number
ORDER BY
    sum_of_cost DESC
LIMIT
    (1);

--Запрос41 :Выбрать название марки название модели и название запчасти которую приходится менять для данной модели чаще других .
SELECT
    mark,
    model,
    sp.name_spare_part,
    COUNT(os.count) AS replacement_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part os ON o.id_order = os.id_order
    JOIN spare_part sp ON os.code = sp.code
GROUP BY
    mark,
    model,
    sp.name_spare_part
ORDER BY
    replacement_count DESC
LIMIT
    (1);

---Запрос42 :Для последнего года выбрать количество просроченных заказов количество заказов выполненных вовремя
---и количество заказов выполненных раньше срока по строкам .
SELECT
    CASE
        WHEN actual_completion > planned_completion THEN ‘ Просроченные заказы ’
        ELSE ‘ Заказы выполненные вовремя ’
    END AS status,
    COUNT(*) AS count_orders
FROM
    orders
WHERE
    EXTRACT(
        YEAR
        FROM
            date
    ) = EXTRACT(
        YEAR(
            FROM
                CURRENT_DATE
        )
    ) -1
GROUP BY
    status;

---Запрос43 :Для каждого месяца выбрать количество просроченных заказов количество заказов выполненных вовремя
---и количество заказов выполненных раньше срока по строкам .
SELECT
    TO_CHAR(date, 'Month') as month_name,
    CASE
        WHEN actual_completion > planned_completion THEN ‘ Просроченные заказы ’
        ELSE ‘ Заказы выполненные вовремя ’
    END as status,
    COUNT(*) as count_orders
FROM
    orders
GROUP BY
    month_name,
    status
ORDER BY
    month_name;

---Запрос44 :Выбрать автомобиль на котором ни одну запчасть не меняли дважды .
SELECT
    number
FROM
    orders O
    LEFT JOIN orders_parts OP on O.order_id = OP.order_id
GROUP BY
    O.car_id
HAVING
    SUM(OP.count) > 2;

---Запрос45 :Выбрать фамилию имя отчество мастера который чинил автомобили всех категорий .
SELECT
    DISTINCT M.surname,
    M.name,
    M.patronymic
FROM
    masters M
    LEFT JOIN orders O on M.master_id = O.master_id
GROUP BY
    M.master_id
HAVING
    COUNT(DISTINCT O.car_category) = COUNT(DISTINCT O.car_category);

---Запрос46 :Выбрать фамилии имена отчества владельцев транспортных средств двух разных категорий которые имеют два автомобиля одной марки .
SELECT
    DISTINCT P.surname,
    P.name,
    P.patronymic
FROM
    persons P
    LEFT JOIN cars C on P.person_id = C.owner_id
GROUP BY
    P.person_id
HAVING
    COUNT(DISTINCT C.category) = 2 -- 47. Выбрать названия запчастей, которые устанавливались на самые старые автомобили.
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

-- 48. Выбрать марку, модель, госномер автомобилей, на которых делали замену, как самой дорогой, так и самой дешевой запчасти.
SELECT
    DISTINCT c.mark,
    c.model,
    c.number
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part oos ON o.id_order = oos.id_order
    JOIN spare_part sp ON oos.code = sp.code
WHERE
    sp.cost = (
        SELECT
            MAX(cost)
        FROM
            spare_part
    )
    OR sp.cost = (
        SELECT
            MIN(cost)
        FROM
            spare_part
    );

-- 49. Вывести фамилии, имена, отчества владельцев, которые обладают 2 автомобилями и более, но не имеют тезок и/или однофамильцев.
SELECT
    p.surname,
    p.name,
    p.patronymic
FROM
    person p
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            car
        WHERE
            car.id_person = p.id_person
    ) >= 2
    AND NOT EXISTS (
        SELECT
            1
        FROM
            person p2
        WHERE
            p2.surname = p.surname
            AND p2.name = p.name
            AND p2.id_person != p.id_person
    );

-- 50. Выбрать тройку самых старых автомобилей.
SELECT
    number,
    mark,
    model,
    year
FROM
    car
ORDER BY
    year ASC
LIMIT
    3;

-- 51. Выбрать все даты прошлого месяца, в которые не осуществляли замену запчастей.
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

-- 52. Выбрать названия поставщиков, количество заказов в прошлом году, процентное отношение ко всем заказам прошлого года.
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