# Setting Up

## Installing Postgresql

Follow the guide below to install postgresql and set up a role that can create a database.
- https://blog.logrocket.com/crud-rest-api-node-js-express-postgresql/#what-postgresql

Following are some of the PSQL commands:
```
CREATE DATABASE sugoi;
```
This creates the sugoi database. You only need to do this once when you are setting up.

```
/c sugoi
```
Switch to the sugoi database if you haven't.

```
psql -d sugoi -U me
```
Connect to postgres in terminal.

```
\q
```
Quit.

## DBeaver

To view and your database easily, it is suggested to install DBeaver.

https://dbeaver.io/download/

## Running DB Migrations

Source: https://db-migrate.readthedocs.io/en/latest/Getting%20Started/usage/

1. Up Migrations

```
db-migrate up         // Run until the most recent migration
db-migrate up -c 5    // Run the next 5 migrations
```

2. Down Migrations

```
db-migrate down         // Undo the last migration
db-migrate down -c 5    // Undo the last 5 migrations
db-migrate reset        // Undo all migrations
```

3. Create Migrations

```
db-migrate create add-customer --sql-file
```

This will generate 2 sql files for each of the up and down migrations. Find the generated sql files and write your sql commands there.

### Notice

As we install db-migrate locally, we might need to replace db-migrate command with the following:
```
node node_modules/db-migrate/bin/db-migrate
```

