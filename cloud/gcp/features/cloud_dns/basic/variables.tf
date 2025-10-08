#######################
# GCP Variables
#######################
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "Default region for GCP resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default zone for GCP resources"
  type        = string
  default     = "us-central1-a"
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

#######################
# DNS Variables
#######################
variable "root_domain" {
  type        = string
  description = "Root domain, e.g., example.com"
}

variable "apex_ipv4" {
  type        = string
  description = "IPv4 address for A record (e.g., Global LB IP)"
}

# variable "apex_ipv6" {
#   type        = string
#   description = "IPv6 address for AAAA record (optional)"
#   default     = null
# }