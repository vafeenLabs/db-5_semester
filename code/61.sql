SELECT
    SUM(total_inc)
FROM
(
        SELECT
            SUM(inc) as total_inc
        FROM
            income_o
        UNION
        SELECT
            SUM("out") * -1
        FROM
            outcome_o
    )