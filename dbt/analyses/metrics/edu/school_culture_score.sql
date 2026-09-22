-- Alias of school_climate_score. Average climate survey score (students, staff and families), per school year.
select
    school_year,
    school_id,
    avg(climate_score) as school_culture_score
from {{ ref('fct_school_climate_surveys') }}
group by 1, 2
order by 1, 2
