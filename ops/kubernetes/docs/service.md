# Service

**basic**

```sh
k apply -f service/basic/basic.yaml

# Verify Pods are running and labels match
kubectl get pods -o wide
kubectl get deploy,po -l app=web

# Confirm endpoints exist (must show pod IPs)
kubectl get endpoints web-nodeport
kubectl get endpoints web-clusterip

minikube ip
```

**basic-deploy**

```sh
k apply -f service/basic-deploy/basic.yaml

k get po -o wide
k get deploy
k get svc

kubectl port-forward svc/web-clusterip 8080:80
# Then visit http://localhost:8080

minikube service web-nodeport --url
# or: curl $(minikube ip):30080 // mac cannot

# delete
k delete -f service/basic-deploy/basic.yaml
```

**trouble shooting**

```sh
kubectl get pods -l app=web -o wide
kubectl get endpoints web-nodeport
kubectl describe svc web-nodeport
```