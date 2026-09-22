with month_end as (
    select *
    from {{ ref('fct_balance_sheet') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    company_id,
    sum(short_term_debt + long_term_debt)
        / nullif(sum(total_assets) - sum(total_liabilities), 0) as debt_to_equity
from month_end
group by all
order by all
