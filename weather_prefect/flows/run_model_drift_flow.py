from prefect import flow, get_run_logger, task
import docker
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import os
from evidently import Report
from evidently.presets import DataDriftPreset
from typing import Any

@task
def load_data_to_check() -> tuple[pd.DataFrame, pd.DataFrame]:
    engine = create_engine(os.getenv("DATABASE_URL"))

    with engine.connect() as conn:
        ref_df = pd.read_sql(
            """
            select *
            from air_quality
            order by _time desc
            limit 720
            """,
            conn
        )

        curr_df = pd.read_sql(
            """
            select *
            from air_quality
            order by _time desc
            limit 168
            """,
            conn
        )
    
    curr_df["log_aqi"] = np.log1p(curr_df["us_aqi"])
    ref_df["log_aqi"] = np.log1p(ref_df["us_aqi"])
    curr_df = curr_df.drop(columns=["us_aqi", "insert_time", "carbon_dioxide", "methane"])
    ref_df = ref_df.drop(columns=["us_aqi", "insert_time", "carbon_dioxide", "methane"])
    
    return ref_df, curr_df

@task
def check_data_drift(ref_df: pd.DataFrame, curr_df: pd.DataFrame) -> dict[str, Any]:
    report = Report(metrics=[DataDriftPreset()])
    run_eval = report.run(reference_data=ref_df, current_data=curr_df)
    result = run_eval.dict()
    return result

@task
def determine_retrain_strategy(result_dict: dict[str, Any], drift_threshold: float = 0.5, warm_start_limit: int = 2) -> str:
    metrics = result_dict['metrics']
    drifted_count = 0
    
    for metric in metrics:
        if metric['metric_id'].startswith('ValueDrift'):
            drift_value = float(metric['value'])
            if drift_value > drift_threshold:
                drifted_count += 1
                
    if drifted_count <= warm_start_limit:
        return "warm_start"
    else:
        return "cold_start"

@flow(log_prints=True)
def run_model_drift_flow():
    logger = get_run_logger()
    ref_df, curr_df = load_data_to_check()
    result = check_data_drift(ref_df=ref_df, curr_df=curr_df)
    retrain_type = determine_retrain_strategy(result_dict=result)
    logger.info(retrain_type)
    # client = docker.from_env()

    # try:
    #     container = client.containers.run(
    #         image="torch_weather-weather_model:latest",
    #         command=["uv", "run", "main.py"],
    #         remove=True,
    #         detach=True,
    #         network="rust_kafka_kafka-net",
            
    #     )
    #     result = container.wait()
    #     logs = container.logs().decode()
    #     logger.info(logs)

    #     if result["StatusCode"] != 0:
    #         raise RuntimeError(
    #             f"Model training failed with {result['StatusCode']}"
    #         )
    #     logger.info("Model fit completed successfully.")

    # except Exception as e:
    #     logger.error(f"Error running model fit container: {e}")
    #     raise
