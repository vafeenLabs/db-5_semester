select
    maker,
    max(price)
from
    pc
    join product using(model)
group by
    maker