/*This code is not SQL. dbt turns macros into SQL*/

with
    /*CTEs*/
    employees_source as (
        select *
        from {{ source('erp_northwind', 'employee') }}
    )
    /*Cleaning data*/
    , rename_data as (
        select 
        cast(ID as int) as pk_employee
        /*Reports to another employee*/
        , cast(REPORTSTO as int) as fk_manager
        , FIRSTNAME || ' ' || LASTNAME as employee_name
        , cast(TITLE as varchar) as employee_position
        , cast(BIRTHDATE as date) as dt_birthdate_employee
        , cast(HIREDATE as date) as dt_hiredate
        , cast(CITY as varchar) as city_employee
        , cast(REGION as varchar) as region_employee
        , cast(COUNTRY as varchar) as country_employee
        --, cast(POSTALCODE as varchar)
        --, cast(ADDRESS as varchar)
        --, cast(TITLEOFCOURTESY as varchar)
        --, cast(HOMEPHONE as varchar)
        --, cast(EXTENSION as varchar)
        --, cast(PHOTO as varchar)
        --, cast(NOTES as varchar)
        --, cast(PHOTOPATH as varchar)
        from employees_source
    )

select *
from rename_data
