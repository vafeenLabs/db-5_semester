SELECT
    ROUND(AVG(numguns), 2)
FROM
    Classes
WHERE
    type = 'bb'