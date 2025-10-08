# 1

```sh
# Example: in-cluster MinIO (dev only)
kubectl create ns argo-data
kubectl -n argo-data apply -f examples/minio.yaml
kubectl -n argo-data port-forward svc/minio 9000:9000 9001:9001

# Delete MinIO deployment + service (assuming examples/minio.yaml was applied)
kubectl -n argo-data delete -f examples/minio.yaml

# Delete just the namespace (removes everything inside)
kubectl delete ns argo-data

# Check pods
kubectl -n argo-data get pods

# Describe a specific pod (see events, volume mounts, env vars)
kubectl -n argo-data describe pod <pod-name>

# Logs from MinIO container
kubectl -n argo-data logs -f deploy/minio

kubectl -n argo-data wait --for=condition=available --timeout=120s deployment/minio
```

- Web Console: http://localhost:9001 (minio/minio123)
- API: http://localhost:9000