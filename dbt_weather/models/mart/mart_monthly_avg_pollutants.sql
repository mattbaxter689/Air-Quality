select d.year,
    d.month,
    avg(f.pm10_rolling_24h) as avg_pm10,
    avg(f.pm2_5_rolling_24h) as avg_pm2_5
from {{ ref("fct_air_quality_measurements")}} f
join {{ ref("dim_date") }} d on date(f._time) = d.day_date
group by d.year, d.month