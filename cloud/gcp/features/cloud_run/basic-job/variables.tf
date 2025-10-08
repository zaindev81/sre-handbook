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
# Cloud Run Job Variables
########################
variable "job_name" {
  type        = string
  description = "Cloud Run Job name"
  default     = "hello-job"
}

variable "image" {
  type        = string
  description = "Container image for the job"
  default     = "us-docker.pkg.dev/cloudrun/container/hello-job"
}

variable "task_count" {
  type        = number
  description = "Total tasks per execution"
  default     = 1
}

variable "parallelism" {
  type        = number
  description = "How many tasks run concurrently"
  default     = 1
}

variable "max_retries" {
  type        = number
  description = "Retry attempts for a failed task"
  default     = 3
}

variable "timeout" {
  type        = string
  description = "Task timeout (e.g., 3600s)"
  default     = "600s"
}

#########################
# Cloud Scheduler Variables
#########################
variable "cron_schedule" {
  type        = string
  description = "Cron schedule for Cloud Scheduler (e.g. '0 * * * *')"
  default     = "0 9 * * *"
}

variable "scheduler_service_account_email" {
  type        = string
  description = "Service Account email used by Scheduler to call the Job (must have roles/run.developer)"
  default     = null
}
