# Kubernetes

- https://github.com/kubernetes/kubernetes

## Platforms

### Minikube

[Minikube](https://minikube.sigs.k8s.io/docs/)

```sh
minikube start
k get po -A
minikube ssh
```

### Kind

[Kind](https://kind.sigs.k8s.io/)

```sh
kind delete cluster
rm -fr ~/.kube/config
kind create cluster --image=kindest/node:v1.33.5
```