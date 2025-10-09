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
# BigQuery Variables
#######################
variable "dataset_id" {
  description = "Dataset ID for BigQuery"
  type        = string
  default     = "ace_dataset"
}

variable "dataset_friendly_name" {
  description = "Friendly display name for the dataset"
  type        = string
  default     = "ACE Dataset"
}

variable "table_id" {
  description = "Table ID for BigQuery table"
  type        = string
  default     = "events"
}