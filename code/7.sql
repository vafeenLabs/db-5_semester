select
    distinct model,
    price
from
    product
    join pc using(model)
where
    maker = 'B'
union
select
    distinct model,
    price
from
    product
    join laptop using(model)
where
    maker = 'B'
union
select
    distinct model,
    price
from
    product
    join printer using(model)
where
    maker = 'B'