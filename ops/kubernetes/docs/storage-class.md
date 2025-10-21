# Storage Class

**basic**

```sh
k get storageclass
k get sc

k apply -f k8s-yaml/storage-class/basic/basic.yaml

k exec -it pod-test -- cat /data/hello.txt

k get pvc

k delete -f k8s-yaml/storage-class/basic/basic.yaml
```

**local**

```sh
k apply -f k8s-yaml/storage-class/local/basic.yaml

k exec -it pod-hostpath-test -- cat /data/hello.txt

minikube ssh
cat /mnt/data/pv1/hello.txt

k delete -f k8s-yaml/storage-class/local/basic.yaml
```