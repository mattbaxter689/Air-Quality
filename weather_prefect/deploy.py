from flows.run_rbt_flow import run_dbt_flow
from prefect import serve

if __name__ == "__main__":
    run_dbt_flow.serve(
        name="scheduled-dbt-run",
        cron="0 * * * *",
        tags=["dbt"],
        description="Runs the DBT container via Docker SDK",
    )
