SELECT
    i.point,
    i."date",
    'inc' AS OPERATION,
    SUM(i.inc) AS MONEY_SUM
FROM
    Income i
    LEFT JOIN Outcome o ON i.point = o.point
    AND i."date" = o."date"
WHERE
    o.point IS NULL
GROUP BY
    i.point,
    i."date"
UNION
SELECT
    o.point,
    o."date",
    'out' AS OPERATION,
    SUM(o."out") AS MONEY_SUM
FROM
    Outcome o
    LEFT JOIN Income i ON o.point = i.point
    AND o."date" = i."date"
WHERE
    i.point IS NULL
GROUP BY
    o.point,
    o."date";