with
    orders as (
        select *
        from {{ ref('stg_erp__orders') }}
    )

    , order_items as (
        select *
        from {{ ref('stg_erp__order_items') }}
    )

    , joined as (
        select
            order_items.PK_ORDER_ITEM
            , order_items.FK_PRODUCT
            , orders.FK_EMPLOYEE
            , orders.FK_CLIENTE
            , orders.FK_SHIPPERS
            , orders.ORDER_DATE
            , orders.REQUIRED_DATE
            , orders.SHIPPED_DATE            
            , order_items.DISCOUNT
            , order_items.UNIT_PRICE
            , order_items.QUANTITY
            , orders.FREIGHT
            , orders.order_number
            , orders.SHIP_NAME
            , orders.SHIP_CITY
            , orders.SHIP_REGION
            , orders.SHIP_COUNTRY
        from order_items
        inner join orders on orders.pk_order = order_items.fk_order
    )
    
    , metrics as (
        select
            *
            , quantity * unit_price as gross_value
            , quantity * unit_price * (1-discount) as net_value
            , freight / (count(*) over(partition by order_number)) as freight_rated
            , case
                when discount > 0 then true
                else false
            end as have_discount
        from joined
    )
    
    , final_select as (
        select
            PK_ORDER_ITEM
            , FK_PRODUCT
            , FK_EMPLOYEE
            , FK_CLIENTE
            , FK_SHIPPERS
            , ORDER_DATE
            , REQUIRED_DATE
            , SHIPPED_DATE
            , DISCOUNT
            , UNIT_PRICE
            , QUANTITY
            , GROSS_VALUE
            , NET_VALUE
            , cast(FREIGHT_RATED as numeric(18,2)) as freight_rated
            , ORDER_NUMBER
            , SHIP_NAME
            , SHIP_CITY
            , SHIP_REGION
            , SHIP_COUNTRY
            , HAVE_DISCOUNT
        from metrics
    )

select *
from final_select