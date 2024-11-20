select
    *
from
    income_o full
    join outcome_o using (point, "date")