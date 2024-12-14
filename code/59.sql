SELECT
    point,
    SUM(COALESCE(inc, 0) - COALESCE("out", 0)) AS balance
FROM
    (
        SELECT
            point,
            "date",
            inc,
            NULL AS "out"
        FROM
            income_o
        UNION
        ALL
        SELECT
            point,
            "date",
            NULL AS inc,
            "out"
        FROM
            outcome_o
    ) t
GROUP BY
    point;