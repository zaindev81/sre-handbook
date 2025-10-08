variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region for GCP resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default zone for GCP resources"
  type        = string
  default     = "us-central1-a"
}

############################################
# Variables (override via tfvars or CLI)
############################################
variable "project_id" { type = string default = "my-gcp-project" }
variable "region"     { type = string default = "us-central1" }
variable "zones" {
  type    = list(string)
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
variable "mig_name"     { type = string  default = "techspire-mig" }
variable "machine_type" { type = string default = "e2-standard-4" }
variable "min_replicas" { type = number default = 1 }
variable "max_replicas" { type = number default = 10 }
variable "target_cpu"   { type = number default = 0.60 }  # 60%
variable "cooldown_s"   { type = number default = 60 }

# Where your compiled single binary is stored (public or with suitable SA access)
# Example: "gs://techspire-artifacts/perfmon/latest/perfmon-linux-amd64"
variable "binary_gcs_url" { type = string }

# Optional: service account email for instances (with access to pull from GCS/Secret Manager/Logging)
variable "instance_sa_email" {
  type    = string
  default = null  # if null, Terraform will not attach a custom SA
}