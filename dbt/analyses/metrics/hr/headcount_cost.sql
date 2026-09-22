-- Fully loaded cost: salary + bonus + benefits + employer taxes, per month.
select
    date_trunc('month', pay_date) as period,
    department,
    sum(
        coalesce(base_pay, 0) + coalesce(bonus_pay, 0)
        + coalesce(benefits_cost, 0) + coalesce(employer_taxes, 0)
    ) as headcount_cost
from {{ ref('fct_payroll') }}
group by 1, 2
order by 1, 2
