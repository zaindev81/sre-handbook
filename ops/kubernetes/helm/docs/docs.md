# Docs Helm

- https://helm.sh/


```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami

helm repo list

# Make sure we get the latest list of charts
helm repo update
helm install bitnami/nginx --generate-name

# It's easy to see what has been released using Helm:
helm list

helm upgrade nginx-1760965274 bitnami/nginx --version 18.1.5

helm uninstall nginx-1760965274
```

```sh
helm list
```