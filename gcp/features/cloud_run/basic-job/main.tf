#######################
# Enable required APIs
#######################
resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifact" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "scheduler" {
  service            = "cloudscheduler.googleapis.com"
  disable_on_destroy = false
}

#######################
# Runtime Service Account (recommended)
#######################
resource "google_service_account" "job_sa" {
  account_id   = "${var.job_name}-sa"
  display_name = "Cloud Run Job runtime SA for ${var.job_name}"
}

#######################
# Cloud Run v2 Job
#######################
resource "google_cloud_run_v2_job" "job" {
  name     = var.job_name
  location = var.region

  template {
    template {
      service_account = google_service_account.job_sa.email

      containers {
        image = var.image

        # Example env
        env {
          name  = "GREETING"
          value = "hello-from-cron-job"
        }

        # Example resource hints (tweak as needed)
        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }
      }

      # Retries
      max_retries  = var.max_retries
      timeout      = var.timeout         # e.g., "3600s"
    }

    # Parallelism
    task_count   = var.task_count      # total tasks per execution
    parallelism  = var.parallelism     # max tasks running at once
  }

  deletion_protection = false

  depends_on = [google_project_service.run]
}

# -------- (Optional) Allow a caller to run the Job --------
# Give a user/SA permission to execute the job (run.jobs.run comes via run.developer)
# Replace MEMBER below as needed (user:, group:, serviceAccount:)
resource "google_cloud_run_v2_job_iam_member" "runner" {
  name     = google_cloud_run_v2_job.job.name
  project  = var.project_id
  location = var.region
  role     = "roles/run.developer"
  member   = "serviceAccount:${google_service_account.job_sa.email}"
}


#######################
# Scheduler Service Account (for Cloud Scheduler to call the Job)
#######################
resource "google_service_account" "scheduler_sa" {
  account_id   = "${var.job_name}-scheduler-sa"
  display_name = "Cloud Scheduler SA for ${var.job_name}"
}

resource "google_cloud_run_v2_job_iam_member" "scheduler_runner" {
  name     = google_cloud_run_v2_job.job.name
  project  = var.project_id
  location = var.region
  role     = "roles/run.developer"
  member   = "serviceAccount:${google_service_account.scheduler_sa.email}"
}

data "google_project" "current" {}
resource "google_service_account_iam_member" "allow_token_creator" {
  service_account_id = google_service_account.scheduler_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-cloudscheduler.iam.gserviceaccount.com"
}

#######################
# Cloud Run Scheduler Job (Optional)
#######################
resource "google_cloud_scheduler_job" "run_job" {
  name        = "${var.job_name}-schedule"
  description = "Execute Cloud Run Job on a schedule"
  schedule    = var.cron_schedule          # 例: "0 * * * *"
  region      = var.region

  http_target {
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${var.job_name}:run"
    http_method = "POST"

    oidc_token {
      service_account_email = google_service_account.scheduler_sa.email
      audience              = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project_id}/jobs/${var.job_name}:run"
    }

    headers = {
      "Content-Type" = "application/json"
    }

    body = base64encode("{}")
  }

  depends_on = [
    google_cloud_run_v2_job.job,
    google_project_service.scheduler
  ]
}