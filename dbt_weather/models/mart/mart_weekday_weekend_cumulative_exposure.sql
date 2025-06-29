select d.is_weekend,
    sum(f.pm10_cumulative_24h) as cumulative_pm10,
    sum(f.pm2_5_cumulative_24h) as cumulative_pm2_5
from {{ ref("fct_air_quality_cumulative_exposure") }} f
join {{ ref("dim_date") }} d ON date(f._time) = d.day_date
group by d.is_weekend