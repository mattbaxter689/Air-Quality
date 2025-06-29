select d.is_weekend,
    avg(f.pm2_5_rolling_24h) as avg_pm2_5,
    avg(f.pm10_rolling_24h) as avg_pm10
from {{ ref("fct_air_quality_measurements") }} f
join {{ ref("dim_date") }} d on date(f._time) = d.day_date
group by d.is_weekend
