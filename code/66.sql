WITH Dates AS (
    SELECT
        TO_DATE('2003-04-01', 'YYYY-MM-DD') + LEVEL - 1 AS dt
    FROM
        DUAL CONNECT BY LEVEL <= TO_DATE('2003-04-07', 'YYYY-MM-DD') - TO_DATE('2003-04-01', 'YYYY-MM-DD') + 1
)
SELECT
    Dates.dt AS Data,
    COALESCE(COUNT(DISTINCT t.trip_no), 0) AS UniversalCount
FROM
    Dates
    LEFT JOIN Pass_in_trip pit ON Dates.dt = pit."date"
    LEFT JOIN Trip t ON t.trip_no = pit.trip_no
    AND t.town_from = 'Rostov'
GROUP BY
    Dates.dt
ORDER BY
    Dates.dt;