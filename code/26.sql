select
    avg(price) as average_price
from
    (
        select
            price
        from
            pc
            join product using(model)
        where
            maker = 'A'
        union
        all
        select
            price
        from
            laptop
            join product using(model)
        where
            maker = 'A'
    ) AVERAGE_PRICE;