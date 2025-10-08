output "cloud_run_url" {
  value       = google_cloud_run_v2_service.app.uri
  description = "Public URL of the Cloud Run service"
}

output "cloud_run_service_name" {
  value       = google_cloud_run_v2_service.app.name
  description = "Name of the Cloud Run service"
}

output "cloud_run_service_id" {
  value       = google_cloud_run_v2_service.app.id
  description = "Full resource ID of the Cloud Run service"
}

output "cloud_run_location" {
  value       = google_cloud_run_v2_service.app.location
  description = "Location/region where the Cloud Run service is deployed"
}

output "cloud_run_service_account_email" {
  value       = google_service_account.run_sa.email
  description = "Email address of the service account used by the Cloud Run service"
}

output "cloud_run_service_account_id" {
  value       = google_service_account.run_sa.id
  description = "Full resource ID of the service account used by the Cloud Run service"
}

output "cloud_run_project_id" {
  value       = google_cloud_run_v2_service.app.project
  description = "GCP project ID where the Cloud Run service is deployed"
}

output "cloud_run_image" {
  value       = var.image
  description = "Container image used by the Cloud Run service"
}

output "cloud_run_ingress" {
  value       = google_cloud_run_v2_service.app.ingress
  description = "Ingress traffic configuration of the Cloud Run service"
}
