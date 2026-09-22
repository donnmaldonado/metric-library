-- (median male salary - median female salary) / median male salary, per month.
with medians as (
    select
        date_trunc('month', pay_date) as period,
        quantile_cont(annual_salary, 0.5) filter (where gender = 'male') as median_male_salary,
        quantile_cont(annual_salary, 0.5) filter (where gender = 'female') as median_female_salary
    from {{ ref('fct_payroll') }}
    group by 1
)

select
    period,
    (median_male_salary - median_female_salary) / nullif(median_male_salary, 0) as gender_pay_gap
from medians
order by 1
