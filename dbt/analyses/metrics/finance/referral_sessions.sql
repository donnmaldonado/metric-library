select
    date_trunc('month', session_date) as period,
    referrer_domain,
    landing_page,
    count(session_id) as referral_sessions
from {{ ref('fct_web_sessions') }}
where medium = 'referral'
group by 1, 2, 3
