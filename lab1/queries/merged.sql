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
-- Запрос 30: Выбрать название марки и название моделей,
-- автомобили которых не представлены в БД.
-- НЕ ВЕРНЕТ НИЧЕГО, НЕПРАВИЛЬНАЯ СТРУКТУРА БД 
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
    ) -- Запрос 32: Для каждого поставщика вывести названия категорий запчастей,
    -- которые он не поставляет.
SELECT
    p.name_provider,
    sp.category
FROM
    provider p
    CROSS JOIN spare_part sp -- Соединяем всех поставщиков с запчастями
    LEFT JOIN order_of_spare_part op ON sp.code = op.code
    LEFT JOIN "order_" o ON op.id_order = o.id_order
WHERE
    o.id_provider != p.id_provider
    OR o.id_provider IS NULL;

-- CROSS
-- В данном запросе: Все записи из таблицы provider (поставщики) 
-- будут соединены с каждой записью из таблицы spare_part (запчасти). 
-- Это позволяет получить все возможные комбинации поставщиков и категорий 
-- запчастей, включая те, которые поставщики не поставляют.
-- LEFT 
-- В данном запросе: Соединяет таблицу запчастей (spare_part) 
-- с таблицей заказов запчастей (order_of_spare_part) по коду запчасти. 
-- Это необходимо для того, чтобы найти запчасти, которые не были заказаны 
-- (и, следовательно, не поставляются поставщиками).
-- Запрос 33: Выбрать фамилии имена отчества мастеров и размер ставки.
SELECT
    surname,
    name,
    patronymic,
    work_rate
FROM
    master
    join person on person.id_person = master.id_person;

-- Запрос 34: Для каждого поставщика выбрать названия всех категорий запчастей
-- и количество различных запчастей им поставляемых. Если поставщик не поставляет 
-- запчасти какой-то категории вывести ноль. Результат отсортировать по id поставщика и по названию категории.
SELECT
    p.name_provider,
    COALESCE(sp.category, 'Unknown') AS category_name,
    COUNT(DISTINCT sp.code) AS parts_count
FROM
    provider p
    LEFT JOIN spare_part sp ON TRUE -- Соединяем всех поставщиков с запчастями
    LEFT JOIN order_of_spare_part op ON sp.code = op.code -- Связываем с заказами
    LEFT JOIN "order_" o ON op.id_order = o.id_order -- Связываем с таблицей заказов
WHERE
    o.id_provider = p.id_provider
    OR o.id_provider IS NULL -- Поставщик связан с заказом
GROUP BY
    p.name_provider,
    sp.category
ORDER BY
    p.id_provider,
    category_name;

-- Функция COALESCE используется для замены значений NULL на заданное значение.
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