with
    int_employees as (
        select *
        from {{ ref('int_employees_selfjoin') }}
    )

select *
from int_employees