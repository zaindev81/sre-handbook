# Ingress

## basic

```sh
minikube start
minikube addons enable ingress
kubectl get pods -n ingress-nginx

kubectl create deployment frontend --image=nginx:stable
kubectl expose deployment frontend --port=80 --name=frontend-service

kubectl create deployment backend --image=kennethreitz/httpbin
kubectl expose deployment backend --port=80 --name=backend-service

kubectl get all -n default

k apply -f k8s-yaml/ingress/basic/basic.yaml
k get ingress

minikube tunnel
echo "127.0.0.1 myapp.local" | sudo tee -a /etc/hosts

# returns from nginx
curl -sI http://myapp.local/
curl -sI http://myapp.local/ | head -n1

# returns from httpbin
curl -sI http://myapp.local/api/get
curl -sI http://myapp.local/api/get | head -n1
```