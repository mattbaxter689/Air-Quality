Use mart with dim/facts tables to alculate things like comparing exposure over months, weekends vs weekdays, cumulative expsoure for various pollutants, compute lags of the 24 hour rolling averages,
add flags when the delta passes a threshold,

create train/test splits in the data using dbt models

build mart_health_risk_summary
add model ownership, tags and descriptions