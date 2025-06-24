{{ config(materialized='incremental') }}

with cte as (
    select *
    from {{ source("public", "air_quality") }}
    {% if is_incremental() %}
    where _time > (select MAX(_time) from {{ this }})
    {% endif %}
)

select *
from cte