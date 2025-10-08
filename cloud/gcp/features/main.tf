locals {
  name_prefix = "${var.gcp_project_name}-${var.environment}"
}

terraform {
  required_version = ">= 1.13.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "= 7.4.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone

  default_labels = {
    project      = var.gcp_project_name
    environment  = var.environment
    managed_by   = "terraform"
  }
}