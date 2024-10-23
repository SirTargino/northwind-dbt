with
    rename_data as (
        select
            orderid::string || '-' || productid::string as pk_order_item
            , cast(orderid as int) as fk_order
            , cast(productid as int) as fk_product
            , cast(discount as numeric(18,2)) as discount
            , cast(unitprice as numeric(18,2)) as unit_price
            , cast(quantity as int) as quantity
        from {{ source('erp_northwind', 'orderdetail') }}
    )

select *
from rename_data