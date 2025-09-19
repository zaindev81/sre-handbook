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