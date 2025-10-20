# Horizontal Pod Autoscaler (HPA)

**prerequisite**

```sh
minikube addons disable metrics-server
minikube addons enable metrics-server
kubectl -n kube-system rollout status deploy/metrics-server

# Wait a minute, then try again
kubectl top nodes
kubectl get pods -n kube-system | grep metrics-server
kubectl logs -n kube-system deployment/metrics-server
kubectl get apiservice v1beta1.metrics.k8s.io -o yaml
```

**basic**

```sh
kubectl apply -f hpa-demo.yaml
kubectl get hpa -w
kubectl get deploy cpu-app -w

kubectl run -it --rm load --image=busybox -- /bin/sh -c 'while true; do wget -q -O- http://cpu-svc.default.svc.cluster.local > /dev/null; done'

kubectl delete -f hpa-demo.yaml
```