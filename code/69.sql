WITH t AS (
    SELECT
        point,
        "date",
        inc,
        0 AS "out"
    FROM
        Income
    UNION
    ALL
    SELECT
        point,
        "date",
        0 as inc,
        "out"
    from
        Outcome
)
SELECT
    t.point,
    TO_CHAR(t."date", 'DD/MM/YYYY') as day,
    (
        SELECT
            SUM(i.inc)
        from
            t i
        WHERE
            i."date" <= t."date"
            AND i.point = t.point
    ) - (
        SELECT
            SUM(i."out")
        from
            t i
        WHERE
            i."date" <= t."date"
            AND i.point = t.point
    ) as rem
FROM
    t
GROUP BY
    t.point,
    t."date"