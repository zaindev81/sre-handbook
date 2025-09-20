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

##########################
# Network variables
##########################
variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "app-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "app-subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for the subnet"
  type        = string
  default     = "10.10.0.0/20"
}

variable "private_range_name" {
  description = "Name of the private IP range for Cloud SQL"
  type        = string
  default     = "cloudsql-private-range"
}

##########################
# Database variables
##########################
variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "demo-pg-private"
}

variable "db_version" {
  description = "Database version"
  type        = string
  default     = "POSTGRES_15"
}

variable "db_tier" {
  description = "Database machine type"
  type        = string
  default     = "db-custom-1-3840"   # 1vCPU / 3.75GB
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "demo-pg"
}

variable "db_user" {
  description = "Database user name"
  type        = string
  default     = "appuser"
}

variable "db_pass" {
  description = "Database user password"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "deletion_protection" {
  description = "Enable or disable deletion protection for Cloud SQL"
  type        = bool
  default     = false
}

##########################
# VM variables
##########################
variable "vm_name" {
  description = "Name of the VM instance"
  type    = string
  default = "demo-app-vm"
}

variable "vm_machine_type" {
  description = "Machine type for the VM instance"
  type    = string
  default = "e2-micro"
}

variable "vm_image" {
  description = "OS image for the VM instance"
  type        = string
  default     = "debian-cloud/debian-12"
}

variable "ssh_user" {
  description = "Username for SSH access"
  type        = string
  default     = "gcpuser"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_tags" {
  description = "Tags to assign to the VM instance"
  type        = list(string)
  default     = ["app-vm", "ssh-access"]
}
