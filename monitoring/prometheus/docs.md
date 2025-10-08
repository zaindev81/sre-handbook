# Prometheus

## 🧭 1. **What is Prometheus?**

**Prometheus** is an **open-source monitoring and alerting system** originally built by SoundCloud, now part of the **CNCF (Cloud Native Computing Foundation)** — just like Kubernetes and OpenTelemetry.

It is designed to **collect, store, and query time-series metrics** (data that changes over time — CPU, memory, latency, etc.) from your infrastructure and applications.

---

## ⚙️ 2. **How Prometheus Works**

Prometheus **pulls metrics** from your applications and systems using **HTTP endpoints** (usually `/metrics`).
It then stores this data locally and allows you to query it using its own query language — **PromQL (Prometheus Query Language)**.

```text
[Application or Service]
   ↓ (expose /metrics endpoint)
[Prometheus Server]
   ↓
[Time-series Database]
   ↓
[Grafana Dashboards or Alerts]
```

---

## 📊 3. **Key Components**

| Component             | Description                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------ |
| **Prometheus Server** | Scrapes and stores metrics.                                                                |
| **Exporters**         | Provide metrics from applications, OS, or databases (e.g., Node Exporter, MySQL Exporter). |
| **Alertmanager**      | Handles alerts (e.g., sends notifications to Slack or email).                              |
| **PromQL**            | Query language to extract and visualize metrics.                                           |

---

## 🧩 4. **Prometheus Metrics Types**

Prometheus classifies metrics into 4 main types:

| Type          | Example                                                          | Description                                  |
| ------------- | ---------------------------------------------------------------- | -------------------------------------------- |
| **Counter**   | `http_requests_total`                                            | Always increases (e.g., number of requests). |
| **Gauge**     | `cpu_temperature`                                                | Can go up or down (e.g., memory usage).      |
| **Histogram** | `request_duration_seconds`                                       | Measures distributions over buckets.         |
| **Summary**   | Similar to Histogram but includes quantiles (e.g., p95 latency). |                                              |

---

## 🔗 5. **Integration with OpenTelemetry**

OpenTelemetry can **export metrics** in Prometheus format or act as a **Prometheus scrape target**.

Typical integration flow:

```text
[Application SDKs (OpenTelemetry)]
   ↓
[OpenTelemetry Collector]
   ↓ (Prometheus Exporter)
[Prometheus Server]
   ↓
[Grafana Dashboards]
```

OR (Prometheus pulls directly):

```text
Prometheus ← (scrapes metrics) ← OpenTelemetry Collector / Instrumented App
```

This means:

* You instrument your code with OpenTelemetry SDKs.
* The Collector exposes `/metrics` endpoint.
* Prometheus scrapes it and stores data.

---

## 🧠 6. **Prometheus + Grafana**

Grafana is the **visualization layer** for Prometheus.

* Prometheus = Collect & store metrics
* Grafana = Visualize metrics

For example:

* Prometheus collects CPU and latency metrics.
* Grafana uses PromQL queries to show real-time dashboards (with alert thresholds and trends).

---

## 🛠️ 7. **Common Use Cases for SREs**

| Use Case                      | Example                                      |
| ----------------------------- | -------------------------------------------- |
| **Infrastructure monitoring** | Node Exporter for CPU, RAM, Disk             |
| **Kubernetes monitoring**     | Kube-state-metrics, cAdvisor                 |
| **Application performance**   | HTTP request latency, error rate             |
| **Alerting**                  | Trigger Slack alerts when latency > 500ms    |
| **SLO/SLI tracking**          | Uptime %, latency %, error budget dashboards |

---

## 🔍 8. **Prometheus vs. OpenTelemetry vs. Grafana**

| Tool              | Type                  | Role                            |
| ----------------- | --------------------- | ------------------------------- |
| **Prometheus**    | Metrics backend       | Stores and queries metrics      |
| **OpenTelemetry** | Data collection layer | Gathers metrics, logs, traces   |
| **Grafana**       | Visualization         | Displays metrics and dashboards |
| **Loki**          | Logging backend       | Collects and stores logs        |
| **Tempo**         | Tracing backend       | Collects and visualizes traces  |

---

## ✅ 9. **Summary**

| You should use...                        | When...                                         |
| ---------------------------------------- | ----------------------------------------------- |
| **Prometheus alone**                     | For lightweight metrics collection and alerting |
| **Prometheus + Grafana**                 | For rich dashboard visualization                |
| **OpenTelemetry + Prometheus**           | For unified, vendor-neutral instrumentation     |
| **OpenTelemetry + Prometheus + Grafana** | For complete observability (ideal modern stack) |

---

Would you like me to show a **diagram** of how OpenTelemetry, Prometheus, and Grafana work together in a Kubernetes environment?
(It’s the standard setup for **SRE monitoring pipelines**.)
