select
    class,
    name,
    country
from
    classes
    join ships using(class)
where
    numGuns >= 10