select
    count(maker)
from
    (
        select
            maker
        from
            product
        group by
            maker
        having
            count(model) = 1
    )