SELECT
    point,
    SUM(COALESCE(inc, 0) - COALESCE("out", 0)) as balance
FROM
    (
        SELECT
            point,
            "date",
            inc,
            NULL AS "out"
        FROM
            income_o
        WHERE
            "date" < TO_DATE('15-04-2001', 'DD-MM-YYYY')
        UNION
        ALL
        SELECT
            point,
            "date",
            NULL AS inc,
            "out"
        FROM
            outcome_o
        WHERE
            "date" < TO_DATE('15-04-2001', 'DD-MM-YYYY')
    )
GROUP BY
    point