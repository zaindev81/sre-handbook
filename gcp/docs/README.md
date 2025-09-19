# GCP

## Gcloud Install

```sh
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz
tar -xf google-cloud-cli-*.tar.gz
./google-cloud-sdk/install.sh
```

## Steps

| Step | Topic                        | Hands-on practice                                                                     |
| ---- | ---------------------------- | ------------------------------------------------------------------------------------- |
| 1    | **Basics of Terraform**      | Install Terraform, learn commands (`init`, `plan`, `apply`), providers, variables.    |
| 2    | **Terraform + GCP provider** | Deploy a basic GCP resource: Create a project, enable APIs, create a service account. |
| 3    | **IAM & Networking**         | Create VPC, subnets, and IAM roles.                                                   |
| 4    | **Compute & Storage**        | Create a GCE instance, GCS bucket with Terraform.                                     |
| 5    | **Modules & DRY**            | Split your code into reusable modules (e.g., `vpc`, `gke`, `storage`).                |
| 6    | **Remote Backend**           | Use GCS bucket as Terraform backend for storing `terraform.tfstate`.                  |
| 7    | **CI/CD Integration**        | Automate deployments with GitHub Actions or Cloud Build.                              |


- https://github.com/terraform-google-modules/terraform-google-project-factory
- https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services
- https://github.com/terraform-google-modules/terraform-google-service-accounts