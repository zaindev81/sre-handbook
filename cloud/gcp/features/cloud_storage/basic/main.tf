terraform {
  required_version = ">= 1.13.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 7.3.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "features" {
  source = "../../"

  gcp_project_id      = var.gcp_project_id
  gcp_project_name    = var.gcp_project_name
  gcp_region          = var.gcp_region
  gcp_zone            = var.gcp_zone

  environment  = "dev"
}

resource "google_storage_bucket" "app_data" {
  name                        = "my-app-data-${var.gcp_project_id}"
  location                    = var.gcp_region

  # Uses standard storage, optimized for frequently accessed data.
  storage_class               = "STANDARD"

  # Enables IAM-only permissions for the entire bucket (no per-object ACLs).
  uniform_bucket_level_access = true                    # use IAM uniformly
  force_destroy               = true                    # safety for prod

  # Keeps old versions of objects when they are overwritten or deleted.
  # Useful for:
  # Backups
  # Rollbacks
  # Auditing changes
  versioning { enabled = true }

  lifecycle_rule {
    action { type = "Delete" }

    condition {
      age        = 90         # delete objects older than 90 days
      with_state = "ARCHIVED" # after a new version exists
    }
  }

  # Default encryption with CMEK (optional—requires an existing KMS key)
  # encryption {
  #   default_kms_key_name = var.kms_key_name # e.g., "projects/.../locations/.../keyRings/.../cryptoKeys/..."
  # }

  # Access logs (optional—needs a logs bucket)
  logging {
    log_bucket        = google_storage_bucket.logs.name
    log_object_prefix = "gcs-access"
  }

  labels = {
    env = var.environment
  }
}

# Logs bucket (private, no versioning required)
resource "google_storage_bucket" "logs" {
  name                        = "my-gcs-logs-${var.gcp_project_id}"
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  versioning { enabled = false }
}
