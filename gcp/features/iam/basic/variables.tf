#######################
# GCP Variables
#######################
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

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

#######################
# Service Account Variables
#######################
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

#######################
# Custom Service Account Variables
#######################
variable "custom_account_id" {
  description = "The ID of the custom service account"
  type        = string
  default     = "terraform-custom-sa"
}

variable "custom_display_name" {
  description = "The display name of the custom service account"
  type        = string
  default     = "Terraform Custom Service Account"
}