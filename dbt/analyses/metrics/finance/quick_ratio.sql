with month_end as (
    select *
    from {{ ref('fct_balance_sheet') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    company_id,
    (sum(cash_balance) + sum(accounts_receivable_balance))
        / nullif(sum(current_liabilities), 0) as quick_ratio
from month_end
group by all
order by all
