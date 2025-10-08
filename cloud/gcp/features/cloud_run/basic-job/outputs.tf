
output "job_name" {
  description = "Name of the Cloud Run job"
  value       = google_cloud_run_v2_job.job.name
}

output "job_region" {
  description = "Region where the Cloud Run job is deployed"
  value       = google_cloud_run_v2_job.job.location
}

output "job_id" {
  description = "Full resource ID of the Cloud Run job"
  value       = google_cloud_run_v2_job.job.id
}

output "job_uid" {
  description = "Server-assigned unique identifier for the Cloud Run job"
  value       = google_cloud_run_v2_job.job.uid
}

output "job_project_id" {
  description = "GCP project ID where the Cloud Run job is deployed"
  value       = google_cloud_run_v2_job.job.project
}

output "job_image" {
  description = "Container image used by the Cloud Run job"
  value       = var.image
}

output "job_service_account_email" {
  description = "Email address of the service account used by the Cloud Run job"
  value       = google_service_account.job_sa.email
}

output "job_service_account_id" {
  description = "Full resource ID of the job service account"
  value       = google_service_account.job_sa.id
}

output "scheduler_service_account_email" {
  description = "Email address of the service account used by Cloud Scheduler"
  value       = google_service_account.scheduler_sa.email
}

output "scheduler_service_account_id" {
  description = "Full resource ID of the scheduler service account"
  value       = google_service_account.scheduler_sa.id
}

output "scheduler_job_name" {
  description = "Name of the Cloud Scheduler job"
  value       = google_cloud_scheduler_job.run_job.name
}

output "scheduler_job_id" {
  description = "Full resource ID of the Cloud Scheduler job"
  value       = google_cloud_scheduler_job.run_job.id
}

output "scheduler_cron_schedule" {
  description = "Cron schedule for the Cloud Scheduler job"
  value       = google_cloud_scheduler_job.run_job.schedule
}

output "job_execution_url" {
  description = "URL endpoint for manually triggering the Cloud Run job"
  value       = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${google_cloud_run_v2_job.job.name}:run"
}

output "job_configuration" {
  description = "Cloud Run job configuration details"
  value = {
    task_count  = var.task_count
    parallelism = var.parallelism
    max_retries = var.max_retries
    timeout     = var.timeout
  }
}