select
    name
from
    classes
    cross join (
        select
            name
        from
            ships
        union
        select
            ship
        from
            outcomes
    )
where
    class = name