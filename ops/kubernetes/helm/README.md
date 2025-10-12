# Helm

```sh
helm create myapp
tree myapp
helm template demo ./myapp | less
helm lint ./myapp
helm install demo ./myapp
kubectl get pods,svc

cat > custom-values.yaml <<'EOF'
replicaCount: 2
service:
  type: NodePort
  port: 80
EOF

helm upgrade demo ./myapp -f custom-values.yaml
kubectl get svc

helm history demo
helm rollback demo 1
helm uninstall demo

# summary
helm create myapp
helm template demo ./myapp
helm install demo ./myapp
helm upgrade demo ./myapp -f custom-values.yaml
helm history demo && helm rollback demo 1
helm uninstall demo
```

| Command                                                    | Description                                      |
| ---------------------------------------------------------- | ------------------------------------------------ |
| `helm repo add bitnami https://charts.bitnami.com/bitnami` | Add a chart repository                           |
| `helm repo update`                                         | Update local repo index                          |
| `helm search repo nginx`                                   | Search for charts (e.g., Nginx)                  |
| `helm install my-nginx bitnami/nginx`                      | Install a chart (creates a **release**)          |
| `helm list`                                                | Show installed releases                          |
| `helm upgrade my-nginx bitnami/nginx --values custom.yaml` | Upgrade release with new settings                |
| `helm uninstall my-nginx`                                  | Delete a release                                 |
| `helm template myapp/`                                     | Render YAML templates locally (without applying) |