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

########################
# Cloud Run Variables
########################
variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "my-cloud-run-service"
}

variable "image" {
  description = "The container image for the Cloud Run service"
  type        = string
  default     = "gcr.io/cloudrun/hello"
}