# Manage Kubernetes in Google Cloud

- https://www.cloudskillsboost.google/course_templates/783


## Managing Deployments Using Kubernetes Engine

```sh
gcloud auth list
gcloud config list project

gcloud compute zones list
gcloud config set compute/zone ZONE

gcloud storage cp -r gs://spls/gsp053/kubernetes .
cd kubernetes

gcloud container clusters create bootcamp \
 --machine-type e2-small \
 --num-nodes 3 \
 --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"
# or
gcloud container clusters create bootcamp \
 --machine-type e2-small \
 --num-nodes 3 \
 --scopes gke-default


kubectl explain deployment
kubectl explain deployment --recursive
kubectl explain deployment.metadata.name

# Task 2. Create a deployment
cat deployments/fortune-app-blue.yaml
kubectl create -f deployments/fortune-app-blue.yaml
kubectl get deployments
kubectl get replicasets
kubectl get pods
cat services/fortune-app.yaml
kubectl create -f services/fortune-app.yaml
kubectl get services fortune-app

curl http://<EXTERNAL-IP>/version
curl http://`kubectl get svc fortune-app -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version


kubectl scale deployment fortune-app-blue --replicas=5
kubectl get pods | grep fortune-app-blue | wc -l
kubectl scale deployment fortune-app-blue --replicas=3
kubectl get pods | grep fortune-app-blue | wc -l

# Task 3. Rolling update
kubectl edit deployment fortune-app-blue
# image line and change the version tag from 1.0.0 to 2.0.0.
kubectl get replicaset
kubectl rollout history deployment/fortune-app-blue
kubectl rollout pause deployment/fortune-app-blue
kubectl rollout status deployment/fortune-app-blue
for p in $(kubectl get pods -l app=fortune-app -o=jsonpath='{.items[*].metadata.name}'); do echo $p && curl -s http://$(kubectl get pod $p -o=jsonpath='{.status.podIP}')/version; echo; done

kubectl rollout resume deployment/fortune-app-blue
kubectl rollout status deployment/fortune-app-blue
kubectl rollout undo deployment/fortune-app-blue
curl http://`kubectl get svc fortune-app -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version

# Task 4. Canary deployments
cat deployments/fortune-app-canary.yaml
kubectl create -f deployments/fortune-app-canary.yaml
kubectl get deployments
for i in {1..10}; do curl -s http://`kubectl get svc fortune-app -o=jsonpath="{.status.loadBalancer.ingress[0].ip}"`/version; echo;
done

# Task 5. Blue-green deployments


# Optional Clean up
gcloud container clusters delete bootcamp

```

```sh
gcloud container clusters create bootcamp \
 --machine-type e2-small \
 --num-nodes 3 \
 --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"
```

| **Part**                                                               | **Meaning**                                                                                                                                                                                  |
| ---------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `gcloud container clusters create bootcamp`                            | Creates a **GKE cluster** named `bootcamp`.                                                                                                                                                  |
| `--machine-type e2-small`                                              | Specifies the VM type for each Kubernetes node.<br> **e2-small** = 2 vCPUs, 2 GB memory → **low-cost, lightweight cluster**.                                                                 |
| `--num-nodes 3`                                                        | Creates **3 nodes (VMs)** in the cluster.<br>This provides redundancy and load balancing.                                                                                                    |
| `--scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"` | Grants **extra permissions** to the nodes:<br> - `projecthosting` → access to Google Code projects (legacy).<br> - `storage-rw` → read and write access to **Google Cloud Storage** buckets. |


## Debug Apps on Google Kubernetes Engine

```sh
gcloud container clusters list
gcloud container clusters get-credentials central --zone ZONE
kubectl get nodes
gcloud services enable cloudaicompanion.googleapis.com

git clone https://github.com/xiangshen-dk/microservices-demo.git
cd microservices-demo

kubectl apply -f release/kubernetes-manifests.yaml
kubectl get pods
export EXTERNAL_IP=$(kubectl get service frontend-external | awk 'BEGIN { cnt=0; } { cnt+=1; if (cnt > 1) print $4; }')
curl -o /dev/null -s -w "%{http_code}\n"  http://$EXTERNAL_IP

# Task 3. Open the application

# Task 4. Create a logs-based metric

# Task 5. Create an alerting policy

# Task 6. Fix the issue and verify the result
```

## Collect Metrics from Exporters using the Managed Service for Prometheus

```sh
# Task 1. Deploy GKE cluster

```

## Manage Kubernetes in Google Cloud: Challenge Lab

```sh
# Task 2. Enable Managed Prometheus on the GKE cluster

```