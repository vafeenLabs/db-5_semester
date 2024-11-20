with max_price as (
    select
        max(price) as max_price
    from
        (
            select
                price
            from
                product
                join pc using(model)
            union
            select
                price
            from
                product
                join laptop using(model)
            union
            select
                price
            from
                product
                join printer using(model)
        )
)
select
    model
from
    product
    join pc using(model)
where
    price = (
        select
            max_price
        from
            max_price
    )
union
select
    model
from
    product
    join laptop using(model)
where
    price = (
        select
            max_price
        from
            max_price
    )
union
select
    model
from
    product
    join printer using(model)
where
    price = (
        select
            max_price
        from
            max_price
    )