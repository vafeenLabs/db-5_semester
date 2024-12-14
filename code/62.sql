SELECT
    SUM(COALESCE(inc, 0)) - SUM(COALESCE("out", 0)) AS total_balance
FROM
    (
        SELECT
            point,
            inc,
            NULL AS "out"
        FROM
            Income_o
        WHERE
            "date" < TO_DATE('2001-04-15', 'YYYY-MM-DD')
        UNION
        ALL
        SELECT
            point,
            NULL AS inc,
            "out"
        FROM
            Outcome_o
        WHERE
            "date" < TO_DATE('2001-04-15', 'YYYY-MM-DD')
    )