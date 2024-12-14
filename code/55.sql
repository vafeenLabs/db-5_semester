SELECT
    Classes.class,
    MIN(Ships.launched) AS year
FROM
    Classes
    LEFT JOIN Ships ON Classes.class = Ships.class
GROUP BY
    Classes.class;