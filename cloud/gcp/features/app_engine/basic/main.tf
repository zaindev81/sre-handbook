# Create the App Engine application
# NOTE: You can only have ONE App Engine application per project,
# and it cannot be deleted without deleting the entire project.
resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = var.app_engine_location

  depends_on = [google_project_service.services]
}

# Bucket for storing deployment artifacts
resource "google_storage_bucket" "artifacts" {
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
  uniform_bucket_level_access = true
}

# Create a ZIP archive from the local "app/" directory.
# If you create the ZIP manually outside of Terraform, you can remove this resource.
# → The hash changes whenever the source files are modified,
#   so this will trigger a new deployment automatically.
data "archive_file" "app_zip" {
  type        = "zip"
  source_dir  = "${path.module}/app"
  output_path = "${path.module}/app.zip"
}

# Upload the ZIP file to the GCS bucket
resource "google_storage_bucket_object" "app_zip" {
  name   = "releases/${var.app_version_id}.zip"
  bucket = google_storage_bucket.artifacts.name
  source = data.archive_file.app_zip.output_path
}

# Create a new App Engine Standard Environment version
resource "google_app_engine_standard_app_version" "default" {
  version_id = var.app_version_id
  service    = "default"            # To create another service, define a separate resource
  runtime    = "python311"          # Change according to your language (e.g., nodejs20, go121, etc.)
  entrypoint = {
    shell = "gunicorn -b :$PORT main:app"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.artifacts.name}/${google_storage_bucket_object.app_zip.name}"
    }
  }

  # Basic automatic scaling configuration for Standard Environment
  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances      = 0
    max_idle_instances      = 1
    target_cpu_utilization  = 0.6
  }

  noop_on_destroy = true  # Prevents actual version deletion when this resource is destroyed
  depends_on      = [google_app_engine_application.app]
}
