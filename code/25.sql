with min_ram as (
    select
        min(ram) as min_ram
    from
        pc
),
max_speed as (
    select
        max(speed) as max_speed
    from
        pc
    where
        ram = (
            select
                min_ram
            from
                min_ram
        )
)
select
    distinct maker
from
    product
    join pc using(model)
where
    ram = (
        select
            min_ram
        from
            min_ram
    )
    and speed = (
        select
            max_speed
        from
            max_speed
    )
    and maker in (
        select
            distinct maker
        from
            product
        where
            type = 'Printer'
    );