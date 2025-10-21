# daemon set

**basic**

```sh
k apply -f k8s-yaml/daemon-set/basic/basic.yaml

kubectl logs -l app=log-agent -n kube-system

k get po -n kube-system
kubectl get daemonsets -n kube-system
kubectl get pods -o wide -n kube-system
```

**demo**

```sh
k apply -f k8s-yaml/daemon-set/basic/demo.yaml
kubectl get daemonset daemonset-demo
kubectl get pods -l app=daemonset-demo -o wide
kubectl logs -l app=daemonset-demo -f

k delete -f k8s-yaml/daemon-set/basic/demo.yaml
```


```sh
k apply -f k8s-yaml/daemon-set/advance

kubectl run curl --image=curlimages/curl:latest --restart=Never -n default -- sleep 3600

kubectl exec -n default -it curl -- sh -lc 'nslookup demo-nginx.default.svc.cluster.local || getent hosts demo-nginx.default.svc.cluster.local || echo "dns failed"'
kubectl exec -n default -it curl -- sh -lc 'for i in $(seq 1 5); do curl -sS http://demo-nginx.default.svc/ >/dev/null; echo "hit $i"; sleep 1; done'

kubectl delete pod curl -n default



kubectl logs -n kube-system -l app=log-agent -c fluent-bit --tail=200 | grep demo-nginx -n

# delete
k delete -f k8s-yaml/daemon-set/advance
```