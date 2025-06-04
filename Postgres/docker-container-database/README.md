# Postgres with Docker setup

This is a simple example of how to set up a PostgreSQL database in a Docker container, so you don't need to install PostgreSQL locally.

For a better experience, it's recommended to have Docker Desktop installed.

## Running the Docker containers

After preparing your `docker-compose.yml` file, run the following command in your terminal to start the containers:

```bash
docker compose up -d
```

To stop the containers:

```bash
docker compose stop
```

## Accessing pgAdmin

Once the containers are running, open `http://localhost:5050` in your browser to access pgAdmin. The **login credentials** (email and password) are defined in your `docker-compose.yml` file under the `my-database-admin` service.

## Connecting to PostgreSQL

1. After logging in, right-click on `Servers` in the left sidebar.
2. Choose `Register` → `Server...`.

### General Tab

- **Name**: Choose any name you like (e.g., `LocalDB`).

### Connection Tab

- **Host name/address**: `my-database` (must match the service name from your `docker-compose.yml`)
- **Port**: `5432`
- **Maintenance database**: `postgres`
- **Username**: `postgres`
- **Password**: `postgres`

Click **Save** to register the server.

## Running SQL queries

- Expand the `Servers` tree to find your database.
- Right-click on the database and select **Query Tool**.
- You can now start writing and executing SQL queries.
