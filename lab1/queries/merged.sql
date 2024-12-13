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
    )
    AND COUNT(op.id_order) > 1;


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
    LEFT JOIN spare_part sp ON p.id_provider = sp.id_provider
GROUP BY
    p.name_provider,
    category_name
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


-- Запрос36: Выбрать госномера, названия модели и марки автомобилей одной модели и одного года выпуска, которые ремонтировались одинаковое количество раз.

WITH RepairsCount AS (
    SELECT
        c.mark, 
        c.model,
        c.year,
        c.number,
        COUNT(o.id_order) AS repairs_count
    FROM
        car c
        JOIN order_ o ON c.number = o.number
    GROUP BY
        c.model, c.year, c.number
)
SELECT
    rc.mark,
    rc.model,
    rc.number,
    rc.repairs_count
FROM
    RepairsCount rc
JOIN (
    SELECT
        model,
        year,
        repairs_count
    FROM
        RepairsCount
    GROUP BY
        model, year, repairs_count
    HAVING COUNT(*) > 1
) identical_repairs ON rc.model = identical_repairs.model
                   AND rc.year = identical_repairs.year
                   AND rc.repairs_count = identical_repairs.repairs_count
ORDER BY
    rc.repairs_count DESC;

-- Это временная таблица, которая подсчитывает количество ремонтов для каждого автомобиля. Для этого:
-- JOIN соединяет таблицы car (автомобили) и order_ (заказы) по номеру автомобиля (c.number = o.number).
-- COUNT(o.id_order) подсчитывает количество заказов (ремонтов) для каждого автомобиля.
-- GROUP BY группирует записи по модели, году и номеру автомобиля, чтобы подсчитать количество ремонтов для каждой комбинации.
-- Результат этого CTE — таблица, где для каждого автомобиля указаны марка, модель, год выпуска, номер и количество ремонтов.


-- Основной запрос выбирает автомобили, которые ремонтировались одинаковое количество раз.
-- JOIN соединяет таблицу RepairsCount с подзапросом, который выбирает модели и года автомобилей с одинаковым количеством ремонтов.
-- В подзапросе:
-- GROUP BY группирует автомобили по модели, году и количеству ремонтов.
-- HAVING COUNT(*) > 1 фильтрует только те группы, где есть больше одного автомобиля с одинаковым количеством ремонтов. 
-- Это означает, что выбираются только те модели и годы, где несколько автомобилей ремонтировались одинаковое количество раз.
-- JOIN в основном запросе связывает автомобили из RepairsCount с этими группами одинаковых 
-- ремонтов по модели, году и количеству ремонтов.

-- Запрос37: Выбрать название марки и модели автомобиля, который ремонтировался чаще других.

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
    1;


-- Запрос38: Выбрать все данные об автомобилях для которых не производились замены запчастей.

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
            INNER JOIN order_of_spare_part ON order_.id_order = order_of_spare_part.id_order
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
    c.mark,
    c.model,
    sp.name_spare_part,
    COUNT(os.count) AS replacement_count
FROM
    car c
    JOIN order_ o ON c.number = o.number
    JOIN order_of_spare_part os ON o.id_order = os.id_order
    JOIN spare_part sp ON os.code = sp.code
GROUP BY
    c.mark,
    c.model,
    sp.name_spare_part
ORDER BY
    c.mark,
    c.model,
    replacement_count DESC;

-- Этот запрос выбирает марку, модель и запчасть, которую заменяют для каждой модели автомобиля чаще всего. 
-- Для этого он объединяет таблицы автомобилей, заказов, заказов запчастей и самих запчастей. 
-- Далее подсчитывается количество замен каждой запчасти для каждой марки и модели. 
-- Результаты группируются по марке, модели и запчасти, после чего сортируются по марке, модели и количеству замен, 
-- так что чаще всего заменяемая запчасть окажется вверху списка.

-- Запрос 42. Для последнего года выбрать количество просроченных заказов, количество заказов, выполненных вовремя, и количество заказов выполненных раньше срока по строкам. Пример результата:
-- Просроченные заказы
-- 10
-- Заказы в срок
-- 90
-- Заказы раньше срока
-- 20
SELECT
    COUNT(CASE 
        WHEN actual_completion > planned_completion THEN 1
        ELSE NULL
    END) AS overdue_orders,
    COUNT(CASE 
        WHEN actual_completion = planned_completion THEN 1
        ELSE NULL
    END) AS on_time_orders,
    COUNT(CASE 
        WHEN actual_completion < planned_completion THEN 1
        ELSE NULL
    END) AS early_orders
FROM
    order_
WHERE
    EXTRACT(YEAR FROM date_of_receipt) = EXTRACT(YEAR FROM CURRENT_DATE) - 1;


-- Запрос 43: Для каждого месяца выбрать количество просроченных заказов,
-- количество заказов выполненных вовремя, и количество заказов выполненных раньше срока по строкам.

-- Основной запрос:
SELECT
    TO_CHAR(date_of_receipt, 'Month') AS month_name,
    COUNT(CASE 
        WHEN actual_completion > planned_completion THEN 1
        ELSE NULL
    END) AS overdue_orders,
    COUNT(CASE 
        WHEN actual_completion = planned_completion THEN 1
        ELSE NULL
    END) AS on_time_orders,
    COUNT(CASE 
        WHEN actual_completion < planned_completion THEN 1
        ELSE NULL
    END) AS early_orders
FROM
    order_
GROUP BY
    TO_CHAR(date_of_receipt, 'Month')
ORDER BY
    TO_CHAR(date_of_receipt, 'Month');

-- TO_CHAR(date_of_receipt, 'Month'): Преобразует дату в текстовый формат, извлекая из нее название месяца.
-- 'Month': Формат, указывающий, что нужно вывести полное название месяца.


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


-- Запрос 45: Выбрать фамилию, имя, отчество мастера, который чинил автомобили всех категорий (легковые и грузовые).

SELECT
    P.surname,
    P.name,
    P.patronymic
FROM
    master M
    JOIN order_ O ON M.id_master = O.id_master
    JOIN car C ON O.number = C.number
    JOIN person P ON M.id_person = P.id_person
GROUP BY
    M.id_master, P.surname, P.name, P.patronymic
HAVING
    COUNT(DISTINCT C.category) = 2;


---Запрос46 :Выбрать фамилии имена отчества владельцев транспортных средств двух разных категорий которые имеют два автомобиля одной марки .

SELECT
    DISTINCT p.surname,
    p.name,
    p.patronymic
FROM
    person p
    JOIN car c1 ON p.id_person = c1.id_person
    JOIN car c2 ON p.id_person = c2.id_person
WHERE
    c1.mark = c2.mark
    AND c1.category <> c2.category
GROUP BY
    p.id_person
HAVING
    COUNT(DISTINCT c1.category) = 2;



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

-- В подзапросе max_min_spare_parts:

-- Находит максимальную и минимальную стоимость запчастей из всей таблицы spare_part. 
-- Эти значения сохраняются как max_cost и min_cost.
-- Основной запрос:

-- Извлекает информацию о марке, модели и номере автомобиля из таблицы car, 
-- а также находит самую дорогую и самую дешевую запчасть для каждого автомобиля.
-- Для каждого автомобиля выбираются максимальная и минимальная стоимость запчастей, которые он использовал.
-- Далее, подзапросы выбирают названия запчастей, стоимость которых соответствует 
-- максимальной и минимальной стоимости для этого автомобиля.
-- Соединения:

-- Запрос соединяет таблицы автомобилей (car), заказов (order_), 
-- заказов запчастей (order_of_spare_part), и самих запчастей (spare_part), 
-- чтобы связать автомобили с запчастями, использованными в ремонтах.
-- Условия:

-- В запросе применяется условие HAVING, которое ограничивает результаты только теми автомобилями, 
-- для которых максимальная стоимость запчасти совпадает с общей максимальной стоимостью запчастей в базе данных,
--  а минимальная стоимость — с общей минимальной.

-- 49. Вывести фамилии, имена, отчества владельцев, которые обладают 2 автомобилями и более, но не имеют однофамильцев или тезок.

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
            (p2.surname = p.surname
            OR p2.name = p.name)
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

-- Основной запрос:
-- Извлекает уникальные даты получения заказов (date_of_receipt) из таблицы order_ за прошлый месяц. 
-- То есть он выбирает заказы, полученные в месяц, предшествующий текущему.

-- Условие o.date_of_receipt >= date_trunc('month', current_date) - INTERVAL '1 month' выбирает все заказы, 
-- полученные начиная с первого дня прошлого месяца.
-- Условие o.date_of_receipt < date_trunc('month', current_date) ограничивает выборку до конца прошлого месяца, 
-- исключая текущий месяц.

-- Подзапрос с NOT EXISTS:
-- Запрос проверяет, что для каждого заказа в основной выборке не существует записи 
-- в таблице order_of_spare_part (таблице, связывающей заказы и запчасти), то есть заказы, 
-- для которых не были использованы запчасти.

-- NOT EXISTS (SELECT 1 FROM order_of_spare_part oos WHERE oos.id_order = o.id_order) исключает все заказы, 
-- для которых есть хотя бы одна запчасть, указанная в таблице order_of_spare_part.

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


-- Основной запрос:
-- Извлекает данные о каждом поставщике (поля p.name_provider — название поставщика) и 
-- подсчитывает количество заказов (COUNT(o.id_order)) за прошлый год, 
-- сделанных с использованием запчастей этого поставщика.

-- LEFT JOIN order_of_spare_part oos ON p.id_provider = oos.id_order — 
-- соединяет таблицу provider с таблицей order_of_spare_part, 
-- чтобы получить информацию о заказах, связанную с конкретными поставщиками.

-- LEFT JOIN order_ o ON oos.id_order = o.id_order — 
-- соединяет таблицу заказов с таблицей order_of_spare_part, чтобы получить данные о самих заказах.
-- WHERE o.date_of_receipt >= date_trunc('year', current_date) - INTERVAL '1 year' 
-- AND o.date_of_receipt < date_trunc('year', current_date) — ограничивает выборку заказами, которые были получены в прошлом году.


-- date_trunc('unit', date) 
-- 1 аргумент — единица времени, до которой будет округляться дата. Это может быть:
-- 'year' — до начала года,
-- 'month' — до начала месяца,
-- 'day' — до начала дня,
-- 'hour' — до начала часа,
-- и так далее.
-- date — дата или временная метка, которую нужно округлить.

