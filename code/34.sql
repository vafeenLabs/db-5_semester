select
    distinct name
from
    classes
    join ships using(class)
where
    launched is not null
    and launched >= 1922
    and displacement > 35000
    and type = 'bb'