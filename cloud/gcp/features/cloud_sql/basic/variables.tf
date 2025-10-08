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

##########################
# Database variables
##########################
variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "demo-pg"
}

variable "db_version" {
  description = "Database version"
  type        = string
  default     = "POSTGRES_15"
}

variable "db_tier" {
  description = "Database machine type"
  type        = string
  default     = "db-custom-1-3840"   # 1vCPU / 3.75GB
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "demo-pg"
}

variable "db_user" {
  description = "Database user name"
  type        = string
  default     = "appuser"
}

variable "db_pass" {
  description = "Database user password"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}