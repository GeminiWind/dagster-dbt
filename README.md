# dbt + Dagster + Docker Compose Example

This project demonstrates how to orchestrate a dbt (Data Build Tool) project using Dagster, all running in Docker containers via Docker Compose.

## Project Structure

```
├── dbtpostgres/           # Your dbt project (models, profiles, macros, etc.)
│   ├── analyses/
│   ├── dbt_packages/
│   ├── logs/
│   ├── macros/
│   ├── models/
│   │   └── staging/
│   │       ├── stg_products.sql
│   │       ├── stg_products.yml
│   │       ├── stg_users.sql
│   │       └── stg_users.yml
│   ├── profiles/         # dbt profiles (contains profiles.yml)
│   ├── seeds/
│   ├── snapshots/
│   ├── tests/
│   ├── venv/
│   ├── dbt_project.yml
│   ├── profiles.yml
│   └── README.md
├── scripts/
│   └── build-dbt.sh      # Script to run dbt build in containers
├── Dockerfile            # Base Dockerfile
├── Dockerfile.dagster    # Dockerfile for Dagster user code server
├── Dockerfile.dagit      # Dockerfile for Dagit UI
├── docker-compose.yml    # Docker Compose configuration
├── init.sql              # Postgres initialization script
├── repository.py         # Dagster repository and asset definitions
├── requirements.txt      # Python dependencies for dbt and Dagster
├── workspace.yaml        # Dagster workspace configuration
├── __init__.py
└── README.md             # This file
```

## Prerequisites
- Docker & Docker Compose installed
- (Optional) Python 3.11+ for local development

## Quickstart

1. **Clone the repository**

2. **Build and start all services:**
   ```sh
   docker-compose up -d --build
   ```

3. **Access the services:**
   - **Dagit UI:** [http://localhost:8080](http://localhost:8080)
   - **Postgres:** Exposed on port 5432

4. **Project Volumes:**
   - The `dagster/` directory is mounted into the containers for live code reloads.
   - The `dbtpostgres/` directory is copied into the containers for dbt asset discovery.

## Common Commands

- **Rebuild containers after code or dependency changes:**
  ```sh
  docker-compose up -d --build
  ```

- **View logs:**
  ```sh
  docker-compose logs -f dagster
  docker-compose logs -f dagit
  ```

- **Stop all services:**
  ```sh
  docker-compose down
  ```

## How it Works

- **Dagster** loads your dbt project as assets using the code in `dagster/repository.py`.
- **Dagit** provides a UI to trigger and monitor dbt runs.
- **Postgres** is used as the data warehouse for dbt models.

## Customization
- Place your dbt models, seeds, and snapshots in `dbtpostgres/`.
- Edit Dagster pipelines and assets in `dagster/`.
- Update dependencies in `dagster/requirements.txt` and rebuild.

## Troubleshooting
- If you do not see your dbt assets in Dagit, ensure the `dbtpostgres/` folder is present in the container and the paths in `repository.py` are correct.
- For import errors, make sure all dependencies are listed in `dagster/requirements.txt` and containers are rebuilt.

## Credits
- [dbt](https://www.getdbt.com/)
- [Dagster](https://dagster.io/)
- [Docker](https://www.docker.com/) 

## Running dbt build in Docker containers

A helper script is provided to run `dbt build` inside your Dagster/Dagit containers. This is useful for materializing your dbt assets from within the running containers.

### Usage

```bash
bash scripts/build-dbt.sh
```

The script will:
- Attempt to run `dbt build` in both the `dagit` and `dagster` containers (if they are running).
- Print a warning if a container is not running and skip it.
- Execute `dbt build` in the `/opt/dagster/app/dbtpostgres` directory inside each container.

### Notes
- Make sure your containers are running before executing the script.
- The script is located at `scripts/build-dbt.sh`.
- You can modify the container names or dbt project path in the script if your setup is different. 

### Additional Notes

- The `dagster/` directory is no longer present; Dagster code is now in `repository.py` at the project root.
- The `scripts/build-dbt.sh` script will run `dbt build` in both `dagit` and `dagster` containers if they are running.
- All dbt project files and configuration are under `dbtpostgres/`.
- The `workspace.yaml` points Dagster to `repository.py` for asset/job definitions.

--- 