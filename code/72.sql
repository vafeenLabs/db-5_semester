WITH T AS(
    SELECT
        pt.id_psg id,
        COUNT(pt."date") trip
    FROM
        pass_in_trip pt
        JOIN trip t ON pt.trip_no = t.trip_no
    GROUP BY
        pt.id_psg
    HAVING
        MAX(t.id_comp) = MIN(t.id_comp)
)
SELECT
    p.name,
    t.trip
FROM
    T t
    JOIN passenger p ON t.id = p.id_psg
WHERE
    t.trip = (
        SELECT
            MAX(trip)
        FROM
            t
    )
ORDER BY
    p.name