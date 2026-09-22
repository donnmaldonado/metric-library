with month_end as (
    select *
    from {{ ref('fct_balance_sheet') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    company_id,
    sum(accounts_payable_balance) as accounts_payable
from month_end
group by all
order by all
