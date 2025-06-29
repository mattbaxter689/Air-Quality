{{ config(materialize="table") }}

with date_range as (
    select min(date(_time)) as start_date,
        max(date(_time)) as end_date
    from {{ ref("stg_open_meteo__air_quality") }}
),

dates as (
    select generate_series(start_date, end_date, interval '1 day') as day_date
    from date_range
)

select day_date,
    extract(year FROM day_date) as year,
    extract(month from day_date) as month,
    to_char(day_date, 'Month') as month_name,
    extract(day from day_date) as day_of_month,
    extract(dow from day_date) as day_of_week,
    to_char(day_date, 'Day') as day_name,
    case when extract(dow from day_date) in (0, 6) then TRUE else FALSE end as is_weekend
from dates
