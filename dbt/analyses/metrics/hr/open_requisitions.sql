-- Requisitions currently open, by month opened.
select
    date_trunc('month', opened_date) as period,
    department,
    count(req_id) as open_requisitions
from {{ ref('fct_requisitions') }}
where status = 'open'
group by 1, 2
order by 1, 2
