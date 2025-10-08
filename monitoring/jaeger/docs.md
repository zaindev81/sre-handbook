# Jaeger

Awesome—Jaeger is perfect for distributed tracing. Here’s the fastest way to get it running and wiring your apps.

# TL;DR choices

* **Local/dev (1 min):** run Jaeger “all-in-one” in Docker.
* **Kubernetes (GKE/KIND/etc.):** install Jaeger via Helm or the Jaeger Operator.
* **App side:** use OpenTelemetry (OTEL) SDK → export to Jaeger (OTLP on :4317).

---

# 1) Local quick start (Docker)

```bash
docker run --rm -it \
  -e COLLECTOR_OTLP_ENABLED=true \
  -p 16686:16686 \   # UI
  -p 4317:4317 \     # OTLP gRPC (apps send traces here)
  jaegertracing/all-in-one:latest
```

Open UI: [http://localhost:16686](http://localhost:16686)
Point apps to `http://localhost:4317`.

---

# 2) Kubernetes install (simple + reliable)

**Namespace**

```bash
kubectl create ns observability
```

**Helm (all-in-one, good for dev/stage)**

```bash
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm repo update
helm install jaeger jaegertracing/jaeger -n observability \
  --set allInOne.enabled=true \
  --set collector.service.otlp.grpc.enabled=true
```

**Access the UI**

```bash
kubectl -n observability port-forward svc/jaeger-query 16686:16686
# open http://localhost:16686
```

**OTLP endpoint for apps in-cluster**

```
http://jaeger-collector.observability.svc.cluster.local:4317
```

> Prod tip: switch storage from in-memory/Badger to **Cassandra/Elasticsearch/ClickHouse** when you need durability & scale. The **Jaeger Operator** makes this easy later.

---

# 3) App instrumentation (OpenTelemetry)

## Node.js (TypeScript OK)

```bash
npm i @opentelemetry/sdk-node \
      @opentelemetry/auto-instrumentations-node \
      @opentelemetry/exporter-trace-otlp-grpc
```

`tracing.ts`

```ts
import { NodeSDK } from "@opentelemetry/sdk-node";
import { OTLPTraceExporter } from "@opentelemetry/exporter-trace-otlp-grpc";
import { getNodeAutoInstrumentations } from "@opentelemetry/auto-instrumentations-node";

const exporter = new OTLPTraceExporter({
  url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT ?? "http://localhost:4317",
});

const sdk = new NodeSDK({
  traceExporter: exporter,
  instrumentations: [getNodeAutoInstrumentations()],
});

sdk.start();
```

Run your app with env:

```bash
export OTEL_SERVICE_NAME=api
export OTEL_TRACES_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://jaeger-collector.observability.svc:4317
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_TRACES_SAMPLER=parentbased_traceidratio
export OTEL_TRACES_SAMPLER_ARG=1.0
node -r ./tracing.js app.js
```

## Go

```go
go get go.opentelemetry.io/otel/sdk/trace \
       go.opentelemetry.io/otel/exporters/otlp/otlpgrpc \
       google.golang.org/grpc
```

```go
exp, _ := otlpgrpc.New(context.Background(),
  otlpgrpc.WithEndpoint("jaeger-collector.observability.svc:4317"),
  otlpgrpc.WithInsecure(),
)
tp := sdktrace.NewTracerProvider(
  sdktrace.WithBatcher(exp),
  sdktrace.WithResource(resource.Default()),
)
otel.SetTracerProvider(tp)
defer tp.Shutdown(context.Background())
```

---

# 4) Kubernetes Service for external access (optional)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: jaeger-query-lb
  namespace: observability
spec:
  type: LoadBalancer
  selector:
    app.kubernetes.io/name: jaeger
    app.kubernetes.io/component: query
  ports:
    - name: ui
      port: 80
      targetPort: 16686
```

---

# 5) Sampling & retention (quick guidance)

* **Dev:** `traceidratio=1.0` to see everything.
* **Prod:** lower ratio (e.g., `0.05`), use **tail-based** sampling in an **OpenTelemetry Collector** if you want smart filtering.
* **Retention:** move to persistent storage (ClickHouse/ES/Cassandra) and set TTL per index/table.

---

Want me to:

* set this up on **GKE** with a minimal, production-ready Helm values file (ClickHouse + OTLP)?
* add **OpenTelemetry Collector** between your apps and Jaeger (recommended for prod)?
* generate **K8s manifests** tailored to your cluster (KIND/GKE/Ingress-NGINX)?