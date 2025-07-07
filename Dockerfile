# Base image with Python
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Optional: Add system dependencies if needed
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install dbt (choose your adapter)
# Other adapters: dbt-bigquery, dbt-snowflake, dbt-redshift, etc.
RUN pip install --no-cache-dir \
    protobuf==4.23.4 \
    dbt-core==1.7.5 \
    dbt-postgres==1.7.5 \
    dbt-snowflake==1.7.5

# Copy your dbt project (optional if mounting volume)
COPY ./dbtpostgres /app

# Default command
CMD ["dbt", "run"]
