select
    model,
    type
from
    Product
where
    regexp_like(model, '^[0-9]+$')
    or regexp_like(model, '^[A-Za-z]+$')