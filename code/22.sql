select
    distinct speed,
    avg(price)
from
    pc
where
    speed > 600
group by
    speed