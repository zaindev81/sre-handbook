resource "random_id" "suffix" {
  byte_length = 3
}

resource "google_storage_bucket" "bq_data" {
  name     = "${var.bq_bucket_name}-${random_id.suffix.hex}"
  location = var.region

  project  = var.project_id
  storage_class = "STANDARD"

  uniform_bucket_level_access = true  # Enables IAM only access
  public_access_prevention    = "enforced"
  versioning {
    enabled = true
  }

  force_destroy = true

  lifecycle_rule {
    action { type = "Delete" }
    condition {
      age = 60
    }
  }

  # retention_policy {
  #   retention_period = 60 * 24 * 60 * 60
  #   is_locked        = false
  # }
}

# Reader role for the BigQuery job runner service account(import source)
# resource "google_storage_bucket_iam_member" "bq_load_reader" {
#   bucket = google_storage_bucket.bq_data.name
#   role   = "roles/storage.objectViewer"
#   member = "serviceAccount:${var.bq_job_runner_sa_email}"
# }

# # Writer role for the BigQuery job runner service account(export destination)
# resource "google_storage_bucket_iam_member" "bq_export_writer" {
#   bucket = google_storage_bucket.bq_data.name
#   role   = "roles/storage.objectCreator"
#   member = "serviceAccount:${var.bq_job_runner_sa_email}"
# }