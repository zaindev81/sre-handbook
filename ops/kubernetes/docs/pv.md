# PV(Persistent Volume)

**basic**

```sh
k apply -f k8s-yaml/pvc/basic/basic1.yaml

# basic2
k apply -f k8s-yaml/pvc/basic/basic2.yaml

k get pv
k get pvc
kubectl describe pvc pvc-demo
kubectl describe pv pv-demo

kubectl exec -it pv-pod -- sh
# inside the container:
ls /data
cat /data/hello.txt

k delete -f k8s-yaml/pvc/basic/basic2.yaml

# basic3
k apply -f k8s-yaml/pvc/basic/basic3.yaml

kubectl exec -it reader-pod -- sh
cat /data/message.txt
```