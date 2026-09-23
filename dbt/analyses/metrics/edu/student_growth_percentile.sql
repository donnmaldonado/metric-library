-- Median student growth percentile, per school year and school.
select
    school_year,
    school_id,
    quantile_cont(growth_percentile, 0.5) as student_growth_percentile
from {{ ref('fct_assessment_results') }}
group by 1, 2
order by 1, 2
