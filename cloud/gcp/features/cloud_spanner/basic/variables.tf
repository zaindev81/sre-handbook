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
# Spanner Variables
#######################
variable "instance_name" {
  description = "The Spanner instance name"
  type        = string
  default     = "spanner-basic"
}

variable "instance_display_name" {
  description = "The Spanner instance display name"
  type        = string
  default     = "Spanner Basic"
}

# Regional or multi-region config. Examples:
# - regional-us-central1
# - nam3 (multi-region), eur3, asia1, etc.
variable "instance_config" {
  description = "The Spanner instance configuration"
  type        = string
  default     = "regional-us-central1"
}

# 1000 = 1 node. Small dev/test can be 100 or 200, but Spanner minimum billed is per instance config limits.
variable "processing_units" {
  description = "The number of processing units for the Spanner instance"
  type        = number
  default     = 1000
}

variable "database_name" {
  description = "The Spanner database name"
  type        = string
  default     = "appdb"
}

variable "env" {
  description = "The environment label for resources"
  type        = string
  default     = "dev"
}

variable "enable_sample_table" {
  description = "Whether to create a sample Users table in the database"
  type        = bool
  default     = true
}

# Optional IAM principal to grant DB access (set to null to skip)
variable "iam_member" {
  description = "An IAM member (user, service account, etc.) to grant spanner.databaseUser role on the database"
  type        = string
  default     = null
}
