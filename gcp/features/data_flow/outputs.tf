output "dataflow_bucket_name" {
  description = "Name of the GCS bucket for Dataflow staging and temporary files"
  value       = google_storage_bucket.dataflow_bucket.name
}

output "dataflow_job_name" {
  description = "The name of the running Dataflow job"
  value       = google_dataflow_job.dataflow_job.name
}

output "dataflow_job_id" {
  description = "The unique ID assigned to the Dataflow job"
  value       = google_dataflow_job.dataflow_job.job_id
}

output "dataflow_job_state" {
  description = "The current state of the Dataflow job (e.g., RUNNING, DONE)"
  value       = google_dataflow_job.dataflow_job.state
}
