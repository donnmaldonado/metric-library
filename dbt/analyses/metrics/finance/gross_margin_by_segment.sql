with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        product_line,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1, 2
),

cogs as (
    select
        date_trunc('month', posted_date) as period,
        product_line,
        sum(cogs_amount) as cogs
    from {{ ref('fct_gl_entries') }}
    group by 1, 2
)

select
    period,
    product_line,
    (revenue - cogs) / nullif(revenue, 0) as gross_margin_by_segment
from revenue
full outer join cogs using (period, product_line)
order by period, product_line
