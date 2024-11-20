select
    point,
    "date",
    sum("out") as out,
    sum(inc) as inc
from
    (
        select
            point,
            "date",
            sum("out") as "out",
            null as inc
        from
            outcome
        group by
            point,
            "date"
        union
        select
            point,
            "date",
            null as "out",
            sum(inc) as inc
        from
            income
        group by
            point,
            "date"
    )
group by
    point,
    "date"