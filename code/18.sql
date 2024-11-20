select
    distinct maker,
    price
from
    product
    join printer using(model)
where
    price = (
        select
            min(price)
        from
            printer
        where
            color = 'y'
    )
    and color = 'y'