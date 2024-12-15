WITH route_cnt AS (
    SELECT
        LEAST(town_from, town_to) AS start_town,
        GREATEST(town_from, town_to) AS end_town,
        COUNT(*) AS cnt
    FROM
        Trip
    GROUP BY
        LEAST(town_from, town_to),
        GREATEST(town_from, town_to)
),
max_flight AS (
    SELECT
        MAX(cnt) AS max_
    FROM
        route_cnt
)
SELECT
    COUNT(*) AS cnt
FROM
    route_cnt r
    JOIN max_flight m ON r.cnt = m.max_;