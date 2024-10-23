with
    rename_data as (
        select
            cast(id as int) as pk_order
            , cast(employeeid as int) as fk_employee
            , cast(customerid as string) as fk_cliente
            , cast(shipvia as int) as fk_shippers
            , cast(id as int) as order_number
            , cast(orderdate as date) as order_date
            , cast(requireddate as date) as required_date
            , cast(shippeddate as date) as shipped_date
            , cast(freight as numeric) as freight
            , cast(shipname as string) as ship_name
            , cast(shipcity as string) as ship_city
            , cast(shipregion as string) as ship_region
            , cast(shipcountry as string) as ship_country
        from {{ source('erp_northwind', '_order_') }}
    )

select *
from rename_data