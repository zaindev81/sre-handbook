# GKE


```sh
kubectl config use-context
kubectl config view
```

##  Use Deployment Manager only.

Register the GKE cluster’s Kubernetes API as a Type Provider in Deployment Manager.

Declare the DaemonSet (kube-system) in a DM template using that type.

Deploy with DM — no extra tools (no Helm/kubectl/Config Connector).

Why this is the simplest:
You manage both the GKE cluster and the DaemonSet from one IaC tool (DM), minimizing services and keeping everything in one pipeline.
Note: Give DM a service account/RBAC so it can create the DaemonSet in kube-system.