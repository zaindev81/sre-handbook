# Create a BigQuery dataset
resource "google_bigquery_dataset" "this" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.dataset_friendly_name
  description                 = "Example BigQuery dataset created via Terraform"
  location                    = var.region           # e.g., "US", "EU", "asia-northeast1"
  default_table_expiration_ms = 2592000000           # 30 days (optional)
  delete_contents_on_destroy  = true                 # Caution: Deletes all tables on destroy
}

# Create a BigQuery table
resource "google_bigquery_table" "events" {
  dataset_id = google_bigquery_dataset.this.dataset_id
  table_id   = var.table_id

  schema = <<EOF
[
  {
    "name": "event_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Unique event identifier"
  },
  {
    "name": "device_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "IoT device identifier"
  },
  {
    "name": "timestamp",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Event timestamp"
  },
  {
    "name": "temperature",
    "type": "FLOAT",
    "mode": "NULLABLE",
    "description": "Temperature in Celsius"
  }
]
EOF

  deletion_protection = false

  depends_on = [google_bigquery_dataset.this]
}
