from flows.run_rbt_flow import run_dbt_flow
from flows.run_model_drift_flow import run_model_drift_flow
from prefect import serve

if __name__ == "__main__":
    serve(
        run_dbt_flow.to_deployment(
            name="scheduled-dbt-run",
            cron="0 * * * *",
            tags=["dbt"],
            description="Runs the DBT container via Docker SDK",
        ),
        run_model_drift_flow.to_deployment(
            name="scheduled-drift-check",
            cron="0 2 * * *",
            tags=["pytorch"],
            description="Checks for drift and fits model using Docker SDK",
        )
    )