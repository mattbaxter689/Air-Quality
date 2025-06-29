{{ config(materialized="table") }}

with cte as (
    select _time,
        pm10,
        pm2_5,
        carbon_monoxide,
        carbon_dioxide,
        nitrogen_dioxide,
        sulphur_dioxide,
        ozone,
        methane,
        uv_index,
        dust,
        aerosol_optical_depth,
        us_aqi
    from {{ ref("stg_open_meteo__air_quality") }}
)

select _time,
    {% for col in ['pm10', 'pm2_5', 'carbon_monoxide', 'carbon_dioxide', 'nitrogen_dioxide', 'sulphur_dioxide', 'ozone', 'methane', 'uv_index', 'dust', 'aerosol_optical_depth', 'us_aqi'] %}
        avg({{ col }}) over (
            order by _time
            rows between 168 preceding and current row
        ) as {{ col }}_rolling_7d{% if not loop.last %},{% endif %}
    {% endfor %}
from cte