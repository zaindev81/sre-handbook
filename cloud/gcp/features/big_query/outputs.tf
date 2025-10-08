output "dataset_name" {
  value = google_bigquery_dataset.this.dataset_id
}

output "table_name" {
  value = google_bigquery_table.events.table_id
}