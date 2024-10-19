with
    rename_data as (
        select
            cast(ID as int) as pk_suppliers
            , cast(COMPANYNAME as varchar) as supplier_name
            , cast(COUNTRY as varchar) as supplier_country
        from {{ source('erp_northwind', 'supplier') }}
    )

select *
from rename_data