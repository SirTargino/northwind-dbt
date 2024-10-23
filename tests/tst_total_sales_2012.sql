/* 
    Esse teste garante que as vendas de 2012 estão corretas em relação
    aos valores auditados da contabilidade:
    $ 226298.5
*/

with
    sales_2012 as (
        select sum(gross_value) as gross_total
        from {{ ref('int_orders_metrics') }}
        where order_date between '2012-01-01' and '2012-12-31'
    )

select *
from sales_2012
where gross_total not between 226298.45 and 226298.55