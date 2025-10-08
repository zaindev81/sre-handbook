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
# Project Services Variables
#######################
variable "activate_apis" {
  description = "List of APIs to activate in the project"
  type        = list(string)
  default     = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "appengine.googleapis.com",
    "cloudbuild.googleapis.com",
    "storage.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "pubsub.googleapis.com",
    "monitoring.googleapis.com",
    "bigtableadmin.googleapis.com",
    "bigtable.googleapis.com",
    "bigquery.googleapis.com",
    "dataflow.googleapis.com"
  ]
}