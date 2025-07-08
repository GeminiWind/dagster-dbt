#!/bin/bash

set -e

CONTAINERS=(dagit dagster)
DBT_PROJECT_PATH="/opt/dagster/app/dbtpostgres"

for CONTAINER_NAME in "${CONTAINERS[@]}"; do
  if docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "Executing 'dbt build' inside the '$CONTAINER_NAME' container..."
    docker exec -it "$CONTAINER_NAME" bash -c "cd $DBT_PROJECT_PATH && dbt build"
  else
    echo "Warning: Container '$CONTAINER_NAME' is not running. Skipping."
  fi
done
