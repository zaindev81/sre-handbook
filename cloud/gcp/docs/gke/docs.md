# GKE

## 0) Set vars (adjust to your values)

```bash
PROJECT_ID="<your-gcp-project>"
CLUSTER_ID="gke-basic-cluster"
```

```sh
# Get cluster credentials
gcloud container clusters get-credentials $CLUSTER_ID --region=us-central1 --project $PROJECT_ID

# Check nodes
kubectl get nodes

kubectl create deploy web --image=nginx
kubectl expose deploy web --type=LoadBalancer --port=80
kubectl get svc web -w

curl http://<ip>
```