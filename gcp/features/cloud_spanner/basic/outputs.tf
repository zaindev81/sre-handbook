# output "spanner_instance" {
#   value = google_spanner_instance.this.name
# }
# output "spanner_database" {
#   value = google_spanner_database.this.name
# }
# output "spanner_endpoint_hint" {
#   value       = "projects/${var.project_id}/instances/${google_spanner_instance.this.name}/databases/${google_spanner_database.this.name}"
#   description = "Use this resource path in clients."
# }
