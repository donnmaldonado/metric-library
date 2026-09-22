-- One row per student per graduation cohort (entered 9th grade in cohort_year): graduation, dropout, transfer, grade 12, FAFSA and college-enrollment outcomes. outcome_date is the cohort's expected graduation date.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as student_cohort_outcome_id,
    cast(null as date   ) as outcome_date,
    cast(null as varchar) as student_id,
    cast(null as varchar) as school_id,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as subgroup,
    cast(null as varchar) as demographic_group,
    cast(null as varchar) as cohort_year,
    cast(null as varchar) as grad_year,
    cast(null as varchar) as college_type,
    cast(null as boolean) as transferred_out,
    cast(null as boolean) as graduated_in_4_years,
    cast(null as boolean) as dropped_out,
    cast(null as boolean) as is_graduate,
    cast(null as boolean) as reached_grade_12,
    cast(null as boolean) as completed_fafsa,
    cast(null as boolean) as enrolled_college_within_12_months,
    cast(null as boolean) as enrolled_college_within_16_months
where false
