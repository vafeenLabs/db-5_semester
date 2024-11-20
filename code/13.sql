select
    avg(speed)
from
    product
    join pc using(model)
where
    maker = 'A'