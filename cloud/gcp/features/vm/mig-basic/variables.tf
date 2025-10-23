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
# Firewall Variables
#######################
variable "ssh_cidr" {
  description = "The CIDR range for SSH access"
  type    = string
  default = "0.0.0.0/0" # tighten to your IP!
}

variable "ssh_tags" {
  description = "The tags to assign to the VM instance"
  type        = list(string)
  default     = ["ssh"]
}

variable "http_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "http_tags" {
  type    = list(string)
  default = ["http"]
}

#######################
# VM Variables
#######################
variable "mig_size" {
  description = "Number of instances in the MIG"
  type        = number
  default     = 2
}