select
    maker,
    avg(hd)
from
    product
    join pc using(model)
where
    maker in (
        select
            maker
        from
            product
        where
            type = 'Printer'
    )
group by maker 

