# Horizontal Pod Autoscaler (HPA)

**prerequisite**

HPA and kubectl top depend on metrics-server.

```sh
minikube addons disable metrics-server

# Install the metrics-server
minikube addons enable metrics-server
kubectl -n kube-system rollout status deploy/metrics-server


# Check the status Make sure it’s running:
kubectl get pods -n kube-system | grep metrics-server
kubectl -n kube-system rollout status deploy/metrics-server

# If it’s not ready, view logs:
kubectl logs -n kube-system deployment/metrics-server

# Verify metrics availability
# Wait a minute, then try again
kubectl top nodes
kubectl top pods --all-namespaces

# Check APIService registration / Finally, confirm that the metrics API is registered:
# This command shows the registration status of the Metrics API
kubectl get apiservices
kubectl get apiservice v1beta1.metrics.k8s.io -o yaml

status:
  conditions:
  - lastTransitionTime: "2025-10-21T23:57:49Z"
    message: all checks passstored
    reason: Passed
    status: "True"
    type: Available
```

**basic**

```sh
k apply -f k8s-yaml/hpa/basic/basic.yaml
k get hpa -w
k get deploy cpu-app -w

kubectl run -it --rm load --image=busybox -- /bin/sh \
  -c 'while true; do wget -q -O- http://cpu-svc.default.svc.cluster.local > /dev/null; done'

k top pod

k delete -f k8s-yaml/hpa/basic/basic.yaml
```