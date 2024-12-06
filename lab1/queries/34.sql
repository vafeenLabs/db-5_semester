-- Запрос 34: Для каждого поставщика выбрать названия всех категорий запчастей
-- и количество различных запчастей им поставляемых. Если поставщик не поставляет 
-- запчасти какой-то категории вывести ноль. Результат отсортировать по id поставщика и по названию категории.
-- Вставка данных для таблицы provider (поставщики)


INSERT INTO provider (id_provider, name_provider, adress, name_manager, surname_manager, patronymic_manager, phone_manager)
VALUES
(1, 'Поставщик 1', 'Адрес 1', 'Иван', 'Иванов', 'Иванович', '89012345678'),
(2, 'Поставщик 2', 'Адрес 2', 'Петр', 'Петров', 'Петрович', '89123456789'),
(3, 'Поставщик 3', 'Адрес 3', 'Сергей', 'Сергеев', 'Сергеевич', '89234567890');

INSERT INTO spare_part (code, name_spare_part, additional_features, quantity, units_of_measurement, cost, category)
VALUES
(101, 'Тормозные колодки', 'Передние', 10, 'шт.', 200, 'Тормозная система'),
(102, 'Фильтр масла', 'Стандартный', 20, 'шт.', 100, 'Двигатель'),
(103, 'Амортизатор', 'Задний', 15, 'шт.', 350, 'Подвеска'),
(104, 'Топливный насос', 'Электрический', 10, 'шт.', 1200, 'Топливная система'),
(105, 'Фильтр воздуха', 'Специальный', 30, 'шт.', 200, 'Воздушная система');

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

