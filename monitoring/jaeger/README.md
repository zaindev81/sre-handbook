# jaeger

- https://www.jaegertracing.io/

```sh
# v1
docker run --rm -it -e COLLECTOR_OTLP_ENABLED=true \
  -p 16686:16686 \
  -p 4317:4317 \
  jaegertracing/all-in-one:latest

# v2
docker run --rm --name jaeger \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 5778:5778 \
  -p 9411:9411 \
  cr.jaegertracing.io/jaegertracing/jaeger:latest
```

**docker compose**

- http://localhost:8080/
- http://localhost:16686/search

```sh
# Pick the newest version
export JAEGER_VERSION=2.11.0
git clone https://github.com/jaegertracing/jaeger.git jaeger
cd jaeger/examples/hotrod
docker compose up
# press Ctrl-C to exit
```