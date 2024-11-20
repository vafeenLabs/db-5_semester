select
    distinct type,
    model,
    speed
from
    laptop
    join product using(model)
where
    speed < (
        select
            min(speed)
        from
            pc
    )