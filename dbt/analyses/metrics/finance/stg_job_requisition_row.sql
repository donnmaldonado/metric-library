-- Requisition records, by month opened.
select
    date_trunc('month', opened_date) as period,
    count(req_id) as stg_job_requisition_row
from {{ ref('fct_requisitions') }}
group by 1
order by 1
