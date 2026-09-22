-- Gross payroll disbursed per month.
select
    date_trunc('month', pay_date) as period,
    sum(gross_pay) as stg_payroll_total
from {{ ref('fct_payroll') }}
group by 1
order by 1
