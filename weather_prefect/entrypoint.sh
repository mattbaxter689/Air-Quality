#!/bin/bash
set -e

sleep 30


# echo "Checking for existing work pool: dbt-pool"
# if ! prefect work-pool inspect dbt-pool > /dev/null 2>&1; then
#   echo "Creating basic process work pool: dbt-pool"
#   prefect work-pool create --type process dbt-pool
# else
#   echo "Work pool dbt-pool already exists — skipping creation."
# fi

echo "Applying deployments..."
python deploy.py

# echo "Starting Prefect worker listening on dbt-pool..."
# prefect worker start --pool dbt-pool