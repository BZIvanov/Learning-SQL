# About

This is an example of how to setup a PostgreSQL database in a docker container so you don't have to install PostgreSQL locally.

It would be nice if you have Docker desktop installed for a better experience with Docker.

# Docker containers

Run the below command in the terminal to start the containers:

```bash
docker compose up -d
```

Run the below command in the terminal to stop the containers:

```bash
docker compose stop
```

# PgAdmin

Once the containers are up and running, visit http://localhost:5050 to access pgAdmin. You can find the login credentials in the `docker-compose.yml` file.

Then right-click `Servers` and `Register` new `Server`.

On the `General` tab provide a `Name` for the server. It could be any name you want.

On the `Connection` tab you should provide the following values (should match the values from docker-compose.yml):

- Host name/address - my-database (should match the service name from docker-compose.yml)
- Port - 5432
- Maintenance database - postgres
- Username - postgres
- Password - postgres

Now you should be able to find your database by expanding `Servers`.

Right-click your database and select `Query Tool`, which will open a query window, where you can start writing your queries.
