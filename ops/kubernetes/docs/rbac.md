# RBAC

```sh
k apply -f k8s-yaml/rbac/basic/basic.yaml

kubectl get sa my-app-sa
kubectl get role read-pods
kubectl get rolebinding read-pods-binding
kubectl get pod my-app

kubectl auth can-i --as=system:serviceaccount:default:my-app-sa -n default list pods
kubectl auth can-i --as=system:serviceaccount:default:my-app-sa -n default get pods
kubectl auth can-i --as=system:serviceaccount:default:my-app-sa --list -n default
```