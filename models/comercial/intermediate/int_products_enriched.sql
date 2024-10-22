with
    products as (
        select *
        from {{ ref('stg_erp__products') }}
    )

    , category as (
        select *
        from {{ ref('stg_erp__category') }}
    )

    , suppliers as (
        select *
        from {{ ref('stg_erp__suppliers') }}
    )

    , products_enriched as (
        /* joins -> largest tables to smallest tables */
        select
            products.PK_PRODUCTS
            , products.PRODUCT_NAME
            , products.QUANTITY_PER_UNIT
            , products.UNIT_PRICE
            , products.UNITS_IN_STOCK
            , products.UNITS_ON_ORDER
            , products.REORDER_LEVEL
            , products.IS_DISCONTINUED
            , category.CATEGORY_NAME
            , category.CATEGORY_DESCRIPTION       
            , suppliers.SUPPLIER_NAME
            , suppliers.SUPPLIER_CITY
            , suppliers.SUPPLIER_COUNTRY
        from products
        left join category on category.pk_category = products.fk_category
        left join suppliers on suppliers.pk_suppliers = products.fk_supplier
    )

select *
from products_enriched