select
    pc1.model,
    pc2.model,
    speed,
    ram
from
    pc pc1
    join pc pc2 using (speed, ram)
where
    pc1.model > pc2.model
group by
    pc1.model,
    pc2.model,
    speed,
    ram;

/ / или
select
    distinct pc1.model,
    pc2.model,
    speed,
    ram
from
    pc pc1
    join pc pc2 using (speed, ram)
where
    pc1.model > pc2.model