# Monitoring

As an **SRE (Site Reliability Engineer)**, monitoring tools are essential for maintaining system **availability, performance, and reliability**. Here’s a detailed overview of the **monitoring ecosystem** that SREs typically use:

---

## 🧭 1. Purpose of Monitoring in SRE

Monitoring allows you to:

* **Detect incidents early** (before users notice)
* **Measure SLIs/SLOs** (Service Level Indicators/Objectives)
* **Diagnose root causes** of outages or slowdowns
* **Understand system behavior** and trends over time
* **Support postmortems and capacity planning**

---

## 🔍 2. Key Categories of Monitoring Tools

### **a. Metrics Monitoring**

Tracks numerical time-series data (CPU, memory, latency, error rate, etc.).

**Popular Tools:**

* **Prometheus** – Open-source standard for time-series metrics with powerful querying (PromQL)
* **Grafana** – Visualization and dashboarding layer (often paired with Prometheus)
* **Datadog / New Relic / Dynatrace** – Commercial platforms for full-stack observability
* **Cloud-native options:**

  * GCP: Cloud Monitoring (Stackdriver)
  * AWS: CloudWatch
  * Azure: Monitor

**Use case:**
Alert when error rate > 5% or latency > 200ms.

---

### **b. Logging**

Collects and analyzes logs for debugging and tracing incidents.

**Popular Tools:**

* **ELK Stack (Elasticsearch, Logstash, Kibana)**
* **Loki (by Grafana Labs)** – lightweight alternative for log aggregation
* **Fluentd / Fluent Bit** – agents for collecting logs
* **Cloud Logging (Stackdriver), CloudWatch Logs**

**Use case:**
Search for "500 Internal Server Error" logs correlated with request IDs.

---

### **c. Tracing (Distributed Tracing)**

Follows requests across microservices to understand latency bottlenecks.

**Popular Tools:**

* **Jaeger** – Open-source tracing system (by Uber)
* **OpenTelemetry (OTel)** – Standardized API/SDK for collecting telemetry data
* **Zipkin** – Another open-source tracing solution
* **Cloud Trace (GCP), AWS X-Ray**

**Use case:**
Identify slow microservice in a distributed API call.

---

### **d. Alerting and Incident Management**

Automatically notifies on-call engineers when thresholds are breached.

**Popular Tools:**

* **Alertmanager** (for Prometheus)
* **PagerDuty / Opsgenie / VictorOps**
* **Slack + Webhooks**
* **Grafana Alerting**

**Use case:**
Trigger an alert if latency exceeds 500ms for 5 minutes.

---

### **e. Synthetic Monitoring**

Simulates user interactions to test system reliability from external perspectives.

**Tools:**

* **Pingdom**
* **Uptrends**
* **k6 / Locust** (for load and performance testing)

**Use case:**
Check API uptime every minute from multiple regions.

---

### **f. Infrastructure Monitoring**

Observes servers, containers, and clusters.

**Tools:**

* **Node Exporter / cAdvisor** (for Prometheus)
* **Kube-State-Metrics**, **Metrics Server** (Kubernetes)
* **Datadog Agent / New Relic Infrastructure**

**Use case:**
Alert when Kubernetes node memory usage > 90%.

---

## 🧠 3. Observability Pillars (Three Golden Signals)

SREs rely on **three core signals**:

| Signal         | Description             | Example Metric           |
| -------------- | ----------------------- | ------------------------ |
| **Latency**    | Time to serve a request | p95 latency              |
| **Traffic**    | Demand on the system    | QPS (Queries per second) |
| **Errors**     | Failed requests         | 5xx error rate           |
| **Saturation** | Resource exhaustion     | CPU %, memory usage      |

*(Originally from Google SRE book — expanded from the “three” to “four” signals.)*

---

## ⚙️ 4. Integration Example (Open-Source Stack)

```
[Prometheus] ← collects metrics
     ↓
[Alertmanager] ← sends alerts to Slack / PagerDuty
     ↓
[Grafana] ← visualizes metrics
     ↓
[Jaeger] ← traces requests
     ↓
[Loki] ← logs (with log correlation)
```

All of these can be integrated into a **Kubernetes cluster** via Helm or sidecar containers.

---

## 📊 5. Example SRE Workflow

1. **Define SLIs/SLOs:**
   e.g., "99.9% of requests under 200ms latency."
2. **Instrument code** using OpenTelemetry.
3. **Collect metrics** using Prometheus.
4. **Visualize dashboards** in Grafana.
5. **Configure alerts** with Alertmanager.
6. **Respond to incidents** via PagerDuty/Slack.
7. **Perform postmortems** and update runbooks.