-- Salary + bonus + benefits + equity expense, per month.
select
    date_trunc('month', pay_date) as period,
    department,
    sum(
        coalesce(base_pay, 0) + coalesce(bonus_pay, 0)
        + coalesce(benefits_cost, 0) + coalesce(equity_expense, 0)
    ) as total_comp_expense
from {{ ref('fct_payroll') }}
group by 1, 2
order by 1, 2
