SELECT
    name
from
    Passenger
WHERE
    ID_psg in (
        SELECT
            ID_psg
        from
            Pass_in_trip
        GROUP BY
            place,
            ID_psg
        HAVING
            count(*) > 1
    )