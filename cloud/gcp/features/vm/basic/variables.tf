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
variable "vm_name" {
  description = "The name of the VM instance"
  type    = string
  default = "basic-vm"
}

variable "machine_type" {
  description = "The machine type for the VM instance"
  type    = string
  default = "e2-medium"
  # default = "e2-micro"
}


variable "startup_script" {
  description = "Optional startup script for the VM"
  type    = string
  default = <<-SH
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable --now nginx
  SH
}

#######################
# SSH key material
#######################
# # Generate an SSH keypair at apply time (or comment this block out if you already have a public key)
# resource "tls_private_key" "ssh" {
#   algorithm = "ED25519"
# }

# # Optional: save the private key locally for you to use (adjust path/permissions as you like)
# resource "local_file" "ssh_private_key" {
#   filename = "${path.module}/id_ed25519"
#   content  = tls_private_key.ssh.private_key_openssh
#   file_permission = "0600"
# }

# variable "ssh_username" {
#   description = "Linux username to map the SSH key to"
#   type        = string
#   default     = "ubuntu"
# }