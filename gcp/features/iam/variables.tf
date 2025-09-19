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

variable "account_id" {
  description = "The ID of the service account"
  type        = string
  default     = "terraform-admin-sa"
}

variable "display_name" {
  description = "The display name of the service account"
  type        = string
  default     = "Terraform Admin Service Account"
}
