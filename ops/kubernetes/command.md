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

### Delete all

```sh
# Delete all workloads in all namespaces
k delete deployment,daemonset,statefulset,replicaset,pod --all --all-namespaces
```