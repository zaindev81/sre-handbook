output "dataset_name" {
  description = "The BigQuery dataset name"
  value = google_bigquery_dataset.this.dataset_id
}

output "table_name" {
  description = "The BigQuery table name"
  value = google_bigquery_table.events.table_id
}