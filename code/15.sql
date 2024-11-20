select
    hd
from
    pc
group by
    hd
having
    count(hd) >= 2