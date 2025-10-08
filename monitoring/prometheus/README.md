# prometheus

```sh
docker-compose up

docker-compose down
```

Prometheus UI: http://localhost:9090
Grafana: http://localhost:3000 (admin/admin)
App: http://localhost:8080

## Query

```sh
## Basic

# CPU Usage (%)
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Memory Usage (%)
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100

# Uptime (seconds)
node_time_seconds - node_boot_time_seconds

## Rate

# CPU Active Time Increase Rate
rate(node_cpu_seconds_total[5m])

# Average Number of Requests in the Past 5 Minutes
rate(nginx_http_requests_total[5m])
```