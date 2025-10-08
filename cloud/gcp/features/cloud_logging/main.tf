# Optional: CMEK key (KMS) if you want customer-managed encryption
# resource "google_kms_crypto_key" "logs_key" { ... }

resource "google_logging_project_bucket_config" "app_logs" {
  project        = var.project_id
  location       = "global"            # or a region like "us-central1"
  retention_days = 30                  # e.g., 30 days
  bucket_id      = "app-logs"

  # optional CMEK
  # cmek_settings {
  #   kms_key_name = google_kms_crypto_key.logs_key.id
  # }
}