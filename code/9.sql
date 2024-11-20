select distinct
    maker
from
    product
    join pc using(model)
where
    speed >= 450