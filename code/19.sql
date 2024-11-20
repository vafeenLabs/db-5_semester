select
    distinct maker,
    (
        select
            avg(l1.screen)
        from
            product p1
            join laptop l1 using(model)
        where
            p1.maker = product.maker
    ) as avg_screen
from
    product
where
    model in (
        select
            model
        from
            laptop
    );