# Grafana

- TestData DB
- CSV
- Postgres

```sh
docker run --rm -d -p 3000:3000 --name=grafana grafana/grafana
```

Access it at http://localhost:3000 (admin/admin for login).

- username: admin
- password: admin

## postgres

```sh
docker run --rm --name postgres-test \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=test \
  -p 5432:5432 \
  -d postgres:16

docker exec -it postgres-test psql -U postgres -d test
```

## Datasource

Host: host.docker.internal:5432
Database: tet
User: postgres
Password: password
SSL Mode: disable

## Query

- hours: Last 5 years

```sql
SELECT * FROM weather_data LIMIT 10;

SELECT
    timestamp as time,
    temperature_celsius as value,
    city as metric
FROM weather_data
WHERE $__timeFilter(timestamp)
ORDER BY timestamp, city

SELECT
    city as "City",
    temperature_celsius as "Temperature (°C)",
    humidity_percent as "Humidity (%)",
    aqi as "Air Quality Index",
    rainfall_mm as "Rainfall (mm)"
FROM weather_data
WHERE timestamp = (SELECT MAX(timestamp) FROM weather_data)
ORDER BY city
```