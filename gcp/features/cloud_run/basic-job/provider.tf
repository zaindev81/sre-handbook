terraform {
  required_version = ">= 1.13.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "root_project" {
  source = "../../"

  gcp_project_id   = var.project_id
  gcp_region       = var.region
  gcp_zone         = var.zone
  gcp_project_name = "NEED_TO_SET"
  environment      = var.environment
}