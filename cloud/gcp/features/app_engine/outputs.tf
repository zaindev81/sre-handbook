output "app_default_url" {
  value       = "https://${google_app_engine_application.app.default_hostname}"
  description = "Default service URL"
}

output "deployed_version" {
  value       = google_app_engine_standard_app_version.default.version_id
  description = "Deployed App Engine version"
}