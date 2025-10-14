#######################
# BigTable Instance Outputs
#######################

output "bigtable_instance_name" {
  description = "The name of the BigTable instance"
  value       = google_bigtable_instance.main.name
}

output "bigtable_instance_id" {
  description = "The ID of the BigTable instance"
  value       = google_bigtable_instance.main.id
}

output "bigtable_instance_display_name" {
  description = "The display name of the BigTable instance"
  value       = google_bigtable_instance.main.display_name
}

output "bigtable_instance_type" {
  description = "The instance type of the BigTable instance"
  value       = google_bigtable_instance.main.instance_type
}

#######################
# BigTable Cluster Outputs
#######################

output "bigtable_cluster_id" {
  description = "The cluster ID of the BigTable instance"
  value       = google_bigtable_instance.main.cluster[0].cluster_id
}

output "bigtable_cluster_zone" {
  description = "The zone where the BigTable cluster is deployed"
  value       = google_bigtable_instance.main.cluster[0].zone
}

output "bigtable_cluster_num_nodes" {
  description = "The number of nodes in the BigTable cluster"
  value       = google_bigtable_instance.main.cluster[0].num_nodes
}

output "bigtable_cluster_storage_type" {
  description = "The storage type of the BigTable cluster"
  value       = google_bigtable_instance.main.cluster[0].storage_type
}

#######################
# BigTable Table Outputs
#######################

output "bigtable_table_name" {
  description = "The name of the BigTable events table"
  value       = google_bigtable_table.events.name
}

output "bigtable_table_id" {
  description = "The ID of the BigTable events table"
  value       = google_bigtable_table.events.id
}

output "bigtable_table_column_families" {
  description = "List of column families in the BigTable events table"
  value       = [for cf in google_bigtable_table.events.column_family : cf.family]
}

#######################
# Connection & Utility Outputs
#######################

output "bigtable_connection_string" {
  description = "Connection string for the BigTable instance"
  value       = "projects/${var.project_id}/instances/${google_bigtable_instance.main.name}"
}

output "bigtable_table_full_name" {
  description = "Full table name including project and instance"
  value       = "projects/${var.project_id}/instances/${google_bigtable_instance.main.name}/tables/${google_bigtable_table.events.name}"
}

output "bigtable_admin_url" {
  description = "Google Cloud Console URL for BigTable instance administration"
  value       = "https://console.cloud.google.com/bigtable/instances/${google_bigtable_instance.main.name}/overview?project=${var.project_id}"
}
