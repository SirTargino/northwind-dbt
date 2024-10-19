with
    rename_data as (
        select
            cast(ID as int) as pk_category
            , cast(CATEGORYNAME as varchar) as category_name
            , cast(DESCRIPTION as varchar) as category_description
        from {{ source('erp_northwind', 'category') }}
    )

select *
from rename_data