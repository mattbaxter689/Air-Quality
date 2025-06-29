{{ config(materialize="table")}}

with cte as (
    select _time,
        pm10,
        pm2_5
    from {{ ref("stg_open_meteo__air_quality") }}
)

select _time,
    {% for col in ['pm10', 'pm2_5'] %}
        sum({{ col }}) over (
            order by _time
            rows between 24 preceding and current row
        ) as {{ col }}_cumulative_24h{% if not loop.last %},{% endif %}
    {% endfor %}
from cte