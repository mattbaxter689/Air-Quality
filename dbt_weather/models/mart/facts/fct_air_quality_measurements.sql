select _time,
    pm2_5_rolling_24h,
    pm10_rolling_24h
from  {{ ref("int_air_quality_rolling_24h") }}