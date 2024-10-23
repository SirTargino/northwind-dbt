with
    int_orders as (
        select *
        from {{ ref('int_orders_metrics') }}
    )

    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )

    , dim_employees as (
        select *
        from {{ ref('dim_employees') }}
    )

select *
from int_orders