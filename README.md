# dbt + Dagster + Docker Compose Example

This project demonstrates how to orchestrate a dbt (Data Build Tool) project using Dagster, all running in Docker containers via Docker Compose.

## Project Structure

```
├── dbtpostgres/           # Your dbt project (models, profiles, etc.)
├── dagster/               # Dagster repository, workspace, and code
├── Dockerfile.dagster     # Dockerfile for Dagster user code server
├── Dockerfile.dagit       # Dockerfile for Dagit UI
├── docker-compose.yml     # Docker Compose configuration
├── requirements.txt       # Python dependencies for dbt and Dagster
└── README.md              # This file
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