SELECT
    country,
    class
FROM
    Classes
WHERE
    country = 'Russia'
UNION
ALL
SELECT
    country,
    class
FROM
    Classes
WHERE
    country <> 'Russia'
    AND NOT EXISTS(
        SELECT
            *
        FROM
            Classes
        WHERE
            country = 'Russia'
    )