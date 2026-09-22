-- Kindergarteners screened as ready / kindergarteners screened, per school year.
select
    school_year,
    school_id,
    count(assessment_result_id) filter (where met_standard)
        / nullif(count(assessment_result_id), 0) as kinder_readiness
from {{ ref('fct_assessment_results') }}
where assessment_type = 'kinder_screening'
group by 1, 2
order by 1, 2
