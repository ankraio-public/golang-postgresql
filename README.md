# Go-Postgres

This project is simple CRUD application built in golang and using PostgreSQL as DB.

## Pre-requisite
1. Install golang v1.11 or above.
2. Install PostgreSQL v10 or above.
3. Create Database and table
  
## PostgreSQL Table

```sql
CREATE TABLE users (
  userid SERIAL PRIMARY KEY,
  name TEXT,
  age INT,
  location TEXT
);
```

## Build Development Docker Image

```bash
docker build --target development  -t golang:dev .
```

## Build Production Docker Image

```bash
docker build --target production  -t golang:prod .
```

## Run Development Docker Image

```bash
docker run -it --rm -p 8080:8080 golang:dev
```

## Run Production Docker Image

```bash
docker run -it --rm -p 8080:8080 golang:prod
```

