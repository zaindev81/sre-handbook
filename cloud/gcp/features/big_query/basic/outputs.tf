output "dataset_id" {
  description = "The BigQuery dataset ID"
  value       = google_bigquery_dataset.main.dataset_id
}

output "dataset_name" {
  description = "The BigQuery dataset name (alias for dataset_id)"
  value       = google_bigquery_dataset.main.dataset_id
}

output "dataset_friendly_name" {
  description = "The BigQuery dataset friendly name"
  value       = google_bigquery_dataset.main.friendly_name
}

output "dataset_location" {
  description = "The location of the BigQuery dataset"
  value       = google_bigquery_dataset.main.location
}

output "dataset_self_link" {
  description = "The self link of the BigQuery dataset"
  value       = google_bigquery_dataset.main.self_link
}

output "table_id" {
  description = "The BigQuery table ID"
  value       = google_bigquery_table.events.table_id
}

output "table_name" {
  description = "The BigQuery table name (alias for table_id)"
  value       = google_bigquery_table.events.table_id
}

output "table_self_link" {
  description = "The self link of the BigQuery table"
  value       = google_bigquery_table.events.self_link
}

output "table_fully_qualified_name" {
  description = "Fully qualified table name for queries"
  value       = "${var.project_id}.${google_bigquery_dataset.main.dataset_id}.${google_bigquery_table.events.table_id}"
}

output "table_reference" {
  description = "Table reference in the format project.dataset.table"
  value       = "${var.project_id}.${google_bigquery_dataset.main.dataset_id}.${google_bigquery_table.events.table_id}"
}

output "query_example" {
  description = "Example SQL query for the events table"
  value       = "SELECT * FROM `${var.project_id}.${google_bigquery_dataset.main.dataset_id}.${google_bigquery_table.events.table_id}` LIMIT 10"
}

#######################
# Cloud Storage Outputs
#######################

output "storage_bucket_name" {
  description = "The name of the BigQuery data Cloud Storage bucket"
  value       = google_storage_bucket.bq_data.name
}

output "storage_bucket_url" {
  description = "The URL of the BigQuery data Cloud Storage bucket"
  value       = google_storage_bucket.bq_data.url
}

output "storage_bucket_self_link" {
  description = "The self link of the BigQuery data Cloud Storage bucket"
  value       = google_storage_bucket.bq_data.self_link
}

output "storage_bucket_location" {
  description = "The location of the BigQuery data Cloud Storage bucket"
  value       = google_storage_bucket.bq_data.location
}

output "storage_bucket_storage_class" {
  description = "The storage class of the BigQuery data Cloud Storage bucket"
  value       = google_storage_bucket.bq_data.storage_class
}

output "external_table_source_uri" {
  description = "The Cloud Storage URI pattern for external table data"
  value       = "gs://${google_storage_bucket.bq_data.name}/events/*.parquet"
}

output "data_upload_path" {
  description = "The Cloud Storage path where data files should be uploaded"
  value       = "gs://${google_storage_bucket.bq_data.name}/events/"
}