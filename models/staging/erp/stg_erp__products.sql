with
    rename_data as (
        select
        cast(ID as int) as pk_products
        , cast(SUPPLIERID as int) as fk_supplier
        , cast(CATEGORYID as int) as fk_category
        , cast(PRODUCTNAME as string) as product_name
        , cast(QUANTITYPERUNIT as string) as quantity_per_unit
        , cast(UNITPRICE as numeric(18,2)) as unit_price /*000000000000000000,00 -> unit_price pattern*/
        , cast(UNITSINSTOCK as int) as units_in_stock
        , cast(UNITSONORDER as int) as units_on_order
        , cast(REORDERLEVEL as int) as reorder_level
        , case /*checks if a product is discontinued*/
            when discontinued = '1' then true
            when discontinued = '0' then false
            else null
        end as is_discontinued
        from {{ source('erp_northwind', 'product') }}
    )

select *
from rename_data