# Enable required APIs
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# Runtime service account (optional but recommended)
# lets you attach just the minimal IAM roles needed
resource "google_service_account" "run_sa" {
  account_id   = "${var.service_name}-sa"
  display_name = "Cloud Run runtime SA for ${var.service_name}"
}

# resource "google_project_iam_member" "storage_access" {
#   project = var.project_id
#   role    = "roles/storage.objectViewer"
#   member  = "serviceAccount:${google_service_account.run_sa.email}"
# }

# Cloud Run v2 service
resource "google_cloud_run_v2_service" "app" {
  name     = var.service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL" # allow from anywhere; change to INGRESS_TRAFFIC_INTERNAL_ONLY if needed

  template {
    service_account = google_service_account.run_sa.email

    containers {
      image = var.image
    }
  }

  depends_on = [google_project_service.run]
}

# Allow unauthenticated invocation (public URL)
resource "google_cloud_run_v2_service_iam_member" "invoker_all" {
  name     = google_cloud_run_v2_service.app.name
  project  = var.project_id
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}