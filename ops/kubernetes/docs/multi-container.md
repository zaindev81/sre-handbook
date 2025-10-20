# multi container


```sh
k apply -f k8s-yaml/multi-container/basic/basic.yaml

kubectl get pods
kubectl logs multi-container-demo -c sidecar
```