# Rolling Update


```sh
k apply -f rollupdate/deployment.yaml

# Then you can monitor progress:
k rollout status deploy
k rollout status deployment
k rollout status deployment/demo-app

k get po -l app=demo-app -o wide

k rollout undo deployment/demo-app

# Or rollback to a specific version:
k rollout undo deployment/demo-app --to-revision=2

# You can see the revision history:
k rollout history deployment/demo-app
```


```sh
# Option A: Imperative one-liner
NS=default
kubectl annotate deployment/demo-app \
  kubernetes.io/change-cause="Upgrade: nginx 1.27" \
  --overwrite -n $NS
kubectl set image deployment/demo-app app=nginx:1.27-alpine -n $NS
kubectl rollout history deployment/demo-app -n $NS
kubectl rollout history deployment/demo-app --revision=3 -n $NS


# Option B: Declarative (edit YAML)
kubectl apply -f deployment-v1.yaml
kubectl rollout status deployment/demo-app
```

**Issue**

```sh
kubectl delete validatingwebhookconfiguration ingress-nginx-admission || true

minikube addons disable ingress
minikube addons enable ingress

kubectl -n ingress-nginx rollout status deploy/ingress-nginx-controller
kubectl get validatingwebhookconfiguration ingress-nginx-admission -o yaml | grep -A3 caBundle
kubectl -n ingress-nginx get endpoints ingress-nginx-controller-admission
```