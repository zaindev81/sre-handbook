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
variable "vm_names" {
  description = "List of VM instance names to create"
  type        = list(string)
  default     = ["my-vm", "my-vm-2"]
}

variable "machine_type" {
  description = "The machine type for the VM instance"
  type    = string
  default = "e2-medium"
}


variable "startup_script" {
  description = "Optional startup script for the VM"
  type    = string
  default = <<-SH
    #!/bin/bash
    apt-get update -y
  SH
}