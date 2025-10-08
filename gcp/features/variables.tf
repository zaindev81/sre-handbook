#######################
# GCP Configuration
#######################
variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_project_name" {
  description = "GCP project name"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for resources"
  type        = string
}

variable "gcp_zone" {
  description = "GCP zone for resources"
  type        = string
}

#######################
# Project Configuration
#######################
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}