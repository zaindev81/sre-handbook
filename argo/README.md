# Argo

- https://argoproj.github.io/
- https://argo-workflows.readthedocs.io/en/latest/

## Useful Commands

```sh
# kind
kind delete cluster
rm -fr ~/.kube/config
kind create cluster --image=kindest/node:v1.34.0

# cluster and nodes
k cluster-info --context kind-kind
k get nodes

# alias
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
```

## Install Argo Workflows

```sh
# Choose the Argo Workflows version
ARGO_WORKFLOWS_VERSION="v3.7.1"

# Create namespace
kubectl create namespace argo

# Install Argo Workflows components (CRDs, controller, server, RBAC, etc.)
kubectl apply -n argo -f \
  "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"
```

## Quick Start

```sh
# Submit the hello-world example workflow to the argo namespace
argo submit -n argo --watch \
  https://raw.githubusercontent.com/argoproj/argo-workflows/main/examples/hello-world.yaml

# List all workflows
argo list -n argo

# Show details of the latest workflow
argo get -n argo @latest

# Port-forward the Argo server service
kubectl -n argo port-forward service/argo-server 2746:2746
```

Open the UI in your browser: https://localhost:2746/

## Get Workflow Info

```sh
# List all workflows in the argo namespace
argo list -n argo

# Get details about the latest workflow
argo get -n argo @latest

# Get details about a specific workflow by name
argo get -n argo <workflow-name>
```

## Cleanup

```sh
# Delete the latest workflow
argo delete -n argo @latest

# Delete a specific workflow by name
argo delete -n argo <workflow-name>

# Delete all workflows in the argo namespace
argo delete --all -n argo

# Delete the Argo namespace (removes all installed components)
kubectl delete namespace argo

# Delete the Kind cluster
kind delete cluster
rm -fr ~/.kube/config
```

## Examples

```sh
# example's hello-world workflow
argo submit -n argo --watch hello-world.yaml
```