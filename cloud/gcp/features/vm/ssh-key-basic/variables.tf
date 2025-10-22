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
  default = "e2-micro"
}

variable "startup_script" {
  description = "Optional startup script for the VM"
  type    = string
  default = <<-EOT
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "Hello from Terraform VM with Nginx!" > /var/www/html/index.nginx-debian.html
  EOT
}

variable "ssh_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_gcp.pub"
}
