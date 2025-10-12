# Command

```sh
# apply
k apply -f nginx.yaml
k apply -f nginx-service.yaml

# get
k get po
k get svc

# delete
k delete -f nginx.yaml
k delete svc nginx-service

# port forward
k port-forward pod/nginx-pod 8080:80
k port-forward service/nginx-service 8080:80

# Test Service Access
http :8080
```

### PV and PVC

```sh
k get pv
k get pvc
kd pv
kd pvc
```

### ConfigMaps

```sh
k get configmaps
k get cm
```

### Create

```sh
k run webapp --image=nginx --dry-run=client -o yaml
```

### Edit

```sh
k edit po basic
k replace --force -f /tmp//tmp/kubectl-edit-3839359674.yaml
```

### Logs

```sh
# Shows the current logs from the default container in that Pod.
kubectl logs env-demo-7f8b6f4d8b-2p5kw

# Shows logs only for the container named web inside that Pod.(multiple containers)
kubectl logs env-demo-7f8b6f4d8b-2p5kw -c web

# kubectl logs -f env-demo-7f8b6f4d8b-2p5kw
kubectl logs -f env-demo-7f8b6f4d8b-2p5kw

# Shows logs from all Pods that have the label app=env-demo
kubectl logs -l app=env-demo --all-containers=true

# Shows logs from the previous container instance (before a restart).
kubectl logs env-demo-7f8b6f4d8b-2p5kw -p
```

### Secrets

```sh
kubectl create secret generic db-secret \
  --from-literal=username=admin \
  --from-literal=password=myS3cretPass

kubectl get secret db-secret
kubectl describe secret db-secret
kubectl get secret db-secret -o yaml
```

### Exec

```sh
kubectl exec -it <pod-name> -- env
kubectl exec -it <pod-name> -- env | grep APP_ENV
```

### Replace

```sh
kubectl delete pod env-demo
kubectl apply -f config/basic-value.yaml
kubectl replace --force -f config/basic-value.yaml
```

### Delete all

```sh
# Delete all workloads in all namespaces
k delete deployment,daemonset,statefulset,replicaset,pod --all --all-namespaces
```


### Plugin

```sh
kubectl -n kube-system get deploy coredns
kubectl -n kube-system get pods | grep -i coredns

minikube addons list | grep -i dns
minikube addons enable coredns
```

### minikube

```sh
minikube stop
minikube delete
minikube start
```