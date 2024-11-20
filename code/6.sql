select
    distinct maker,
    speed
from
    product
    join laptop using(model)
where
    laptop.hd >= 10