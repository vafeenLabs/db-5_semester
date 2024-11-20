select
    maker,
    count(model)
from
    product
where
    type = 'PC'
group by
    maker
having
    count(model) >= 3