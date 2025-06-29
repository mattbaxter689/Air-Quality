select _time,
    pm10_cumulative_24h,
    pm2_5_cumulative_24h
from {{ ref("int_pollutant_cumulative_exposure_24h") }}