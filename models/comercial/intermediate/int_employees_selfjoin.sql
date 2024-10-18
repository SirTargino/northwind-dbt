with
    employee as (
    select *
    from {{ ref('stg_erp__employees') }}
    )

    , joined as (
        select
            employee.PK_EMPLOYEE
            , employee.FK_MANAGER
            , employee.EMPLOYEE_NAME
            , manager.employee_name as manager_name
            , employee.EMPLOYEE_POSITION
            , employee.DT_BIRTHDATE_EMPLOYEE
            , employee.DT_HIREDATE
            , employee.CITY_EMPLOYEE
            , employee.REGION_EMPLOYEE
            , employee.COUNTRY_EMPLOYEE
        from employee
        left join employee as manager
            on employee.fk_manager = manager.pk_employee
    )

select *
from joined
