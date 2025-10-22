# gateway

**prerequisite**

```sh
# (A) Install Gateway API CRDs
# kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml

kubectl apply -f https://github.com/envoyproxy/gateway/releases/download/latest/quickstart.yaml -n default

# (B) Install Envoy Gateway via Helm
helm install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v0.0.0-latest \
  -n envoy-gateway-system \
  --create-namespace
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

# confirm
kubectl get pods -n envoy-gateway-system
kubectl get gatewayclass

helm repo remove envoy-gateway 2>/dev/null || true

k apply -f k8s-yaml/gateway/basic/basic.yaml

k delete -f k8s-yaml/gateway/basic/basic.yaml
```

**basic**