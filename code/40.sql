select
    maker,
    max(type)
from
    product
group by
    maker
having
    count(model) > 1
    and count(distinct type) = 1