-- K = invites per referring user x invite conversion rate = converted invites / referring users.
select
    date_trunc('month', referral_date) as period,
    count(case when is_converted then referral_id end)
        / nullif(count(distinct referrer_user_id), 0) as viral_coefficient
from {{ ref('fct_referrals') }}
group by 1
