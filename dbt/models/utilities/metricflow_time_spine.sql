-- Daily time spine for MetricFlow (2015-01-01 .. 2034-12-31).
{{ config(materialized='table') }}
select cast(range as date) as date_day
from range(date '2015-01-01', date '2035-01-01', interval 1 day)
