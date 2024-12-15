WITH route_cnt AS (
    SELECT
        town_from,
        town_to,
        COUNT(*) AS flight_count
    FROM
        Trip
    GROUP BY
        town_from,
        town_to
),
max_flight AS (
    SELECT
        MAX(flight_count) AS max_flight
    FROM
        route_cnt
)
SELECT
    COUNT(*) AS route
FROM
    route_cnt
    JOIN max_flight ON route_cnt.flight_count = max_flight.max_flight;