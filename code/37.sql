select class
from (
    select name, class from ships
    union
    select class as name, class
    from classes, outcomes
    where classes.class = outcomes.ship
) s
group by class
having count(s.name) = 1;
