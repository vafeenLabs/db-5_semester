select
    distinct maker
from
    product
where
    maker in (
        select
            maker
        from
            product
        where
            type = 'PC'
    )
    and maker not in (
        select
            maker
        from
            product
        where
            type = 'Laptop'
    )
