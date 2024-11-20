select
    distinct maker
from
    Product
where
    maker in (
        select
            maker
        from
            product
            join pc using(model)
        where
            speed >= 750
    )
    and maker in (
        select
            maker
        from
            laptop
            join product using (model)
        where
            speed >= 750
    )