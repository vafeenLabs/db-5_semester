select
    distinct ou.ship
from
    outcomes ou
where
    ou.result = 'damaged'
    and exists (
        select
            *
        from
            battles bc
            join outcomes ot on ot.battle = bc.name
        where
            ou.ship = ot.ship
            and bc."date" > (
                select
                    bt."date"
                from
                    battles bt
                where
                    ou.battle = bt.name
            )
    );