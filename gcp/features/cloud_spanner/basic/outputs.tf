#######################
# Spanner Instance Outputs
#######################
output "spanner_instance_name" {
  description = "Name of the Spanner instance"
  value       = google_spanner_instance.this.name
}

output "spanner_instance_id" {
  description = "Full resource ID of the Spanner instance"
  value       = google_spanner_instance.this.id
}

output "spanner_instance_display_name" {
  description = "Display name of the Spanner instance"
  value       = google_spanner_instance.this.display_name
}

output "spanner_instance_config" {
  description = "Configuration of the Spanner instance"
  value       = google_spanner_instance.this.config
}

output "spanner_instance_processing_units" {
  description = "Number of processing units for the Spanner instance"
  value       = google_spanner_instance.this.processing_units
}

output "spanner_instance_state" {
  description = "Current state of the Spanner instance"
  value       = google_spanner_instance.this.state
}

#######################
# Spanner Database Outputs
#######################
output "spanner_database_name" {
  description = "Name of the Spanner database"
  value       = google_spanner_database.this.name
}

output "spanner_database_id" {
  description = "Full resource ID of the Spanner database"
  value       = google_spanner_database.this.id
}

output "spanner_database_state" {
  description = "Current state of the Spanner database"
  value       = google_spanner_database.this.state
}

#######################
# Connection Information
#######################
output "spanner_connection_string" {
  description = "Connection string for the Spanner database"
  value       = "projects/${var.project_id}/instances/${google_spanner_instance.this.name}/databases/${google_spanner_database.this.name}"
}

output "spanner_instance_uri" {
  description = "URI of the Spanner instance"
  value       = "projects/${var.project_id}/instances/${google_spanner_instance.this.name}"
}

#######################
# Configuration Details
#######################
output "spanner_configuration" {
  description = "Complete Spanner configuration details"
  value = {
    project_id        = var.project_id
    instance_name     = google_spanner_instance.this.name
    database_name     = google_spanner_database.this.name
    instance_config   = google_spanner_instance.this.config
    processing_units  = google_spanner_instance.this.processing_units
    environment       = var.env
    sample_table_enabled = var.enable_sample_table
  }
}

#######################
# IAM Information
#######################
output "spanner_iam_member" {
  description = "IAM member granted database access (if any)"
  value       = var.iam_member
}

output "spanner_database_iam_binding_id" {
  description = "ID of the database IAM binding (if created)"
  value       = var.iam_member != null ? google_spanner_database_iam_member.db_user[0].id : null
}

#######################
# Cost and Billing Information
#######################
output "spanner_estimated_nodes" {
  description = "Estimated number of nodes (processing_units / 1000)"
  value       = google_spanner_instance.this.processing_units / 1000
}

output "spanner_billing_info" {
  description = "Billing-related information for the Spanner instance"
  value = {
    processing_units = google_spanner_instance.this.processing_units
    estimated_nodes  = google_spanner_instance.this.processing_units / 1000
    config          = google_spanner_instance.this.config
    instance_name   = google_spanner_instance.this.name
  }
}