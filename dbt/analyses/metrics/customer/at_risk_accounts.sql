with scores as (
    select
        *,
        max(score_date) over (partition by date_trunc('month', score_date)) as last_score_date
    from {{ ref('fct_customer_health_scores') }}
)

-- Accounts below the risk threshold on the last score date of each month
select
    date_trunc('month', score_date) as period,
    segment,
    count(distinct customer_id) as at_risk_accounts
from scores
where score_date = last_score_date
  and health_score < 50
group by 1, 2
