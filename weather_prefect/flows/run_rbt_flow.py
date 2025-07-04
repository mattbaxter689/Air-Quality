from prefect import flow, get_run_logger
import docker


@flow(log_prints=True)
def run_dbt_flow():
    logger = get_run_logger()
    client = docker.from_env()

    try:
        container = client.containers.run(
            image="dbt_weather-dbt_weather:latest",
            command=["uv", "run", "dbt", "run"],
            detach=True,
            network="rust_kafka_kafka-net",
            environment={
                "DBT_TARGET": "prod",
                "DBT_PROFILES_DIR": "/root/.dbt",
            },
        )
        result = container.wait()
        logs = container.logs().decode()
        logger.info(logs)

        if result["StatusCode"] != 0:
            raise RuntimeError(
                f"DBT run failed with code {result['StatusCode']}"
            )
        logger.info("DBT completed successfully.")
        container.remove()

    except Exception as e:
        logger.error(f"Error running DBT container: {e}")
        raise
