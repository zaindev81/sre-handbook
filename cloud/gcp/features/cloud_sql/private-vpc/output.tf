# ==============================
# Network Outputs
# ==============================

output "vpc_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "vpc_id" {
  description = "The unique identifier of the VPC network"
  value       = google_compute_network.vpc.id
}

output "vpc_self_link" {
  description = "Self-link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_id" {
  description = "The unique identifier of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_cidr" {
  description = "CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "private_ip_range" {
  description = "Reserved private IP range for Cloud SQL"
  value       = google_compute_global_address.private_range.address
}

output "private_ip_range_name" {
  description = "Name of the reserved private IP range"
  value       = google_compute_global_address.private_range.name
}

# ==============================
# Cloud SQL Outputs
# ==============================

output "sql_instance_name" {
  description = "Name of the Cloud SQL instance"
  value       = google_sql_database_instance.pg_private.name
}

output "sql_instance_connection_name" {
  description = "Connection name for the Cloud SQL instance"
  value       = google_sql_database_instance.pg_private.connection_name
}

output "sql_instance_private_ip" {
  description = "Private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.pg_private.private_ip_address
}

output "sql_instance_public_ip" {
  description = "Public IP address of the Cloud SQL instance (should be empty for private instances)"
  value       = google_sql_database_instance.pg_private.public_ip_address
}

output "sql_instance_self_link" {
  description = "Self-link of the Cloud SQL instance"
  value       = google_sql_database_instance.pg_private.self_link
}

output "sql_instance_server_ca_cert" {
  description = "Server CA certificate of the Cloud SQL instance"
  value       = google_sql_database_instance.pg_private.server_ca_cert
  sensitive   = true
}

output "database_name" {
  description = "Name of the database"
  value       = google_sql_database.appdb_private.name
}

output "database_user" {
  description = "Database username"
  value       = google_sql_user.app_private.name
}

# ==============================
# VM Instance Outputs
# ==============================

output "vm_instance_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.app_vm.name
}

output "vm_instance_id" {
  description = "Unique identifier of the VM instance"
  value       = google_compute_instance.app_vm.instance_id
}

output "vm_internal_ip" {
  description = "Internal IP address of the VM instance"
  value       = google_compute_instance.app_vm.network_interface[0].network_ip
}

output "vm_external_ip" {
  description = "External IP address of the VM instance"
  value       = google_compute_instance.app_vm.network_interface[0].access_config[0].nat_ip
}

output "vm_machine_type" {
  description = "Machine type of the VM instance"
  value       = google_compute_instance.app_vm.machine_type
}

output "vm_zone" {
  description = "Zone where the VM instance is deployed"
  value       = google_compute_instance.app_vm.zone
}

output "vm_self_link" {
  description = "Self-link of the VM instance"
  value       = google_compute_instance.app_vm.self_link
}

# ==============================
# Connection Information
# ==============================

output "database_connection_info" {
  description = "Database connection information"
  value = {
    host     = google_sql_database_instance.pg_private.private_ip_address
    port     = 5432
    database = google_sql_database.appdb_private.name
    username = google_sql_user.app_private.name
  }
  sensitive = false
}

output "psql_connection_string" {
  description = "PostgreSQL connection string for use within the VPC"
  value       = "postgresql://${google_sql_user.app_private.name}:[PASSWORD]@${google_sql_database_instance.pg_private.private_ip_address}:5432/${google_sql_database.appdb_private.name}"
  sensitive   = false
}

output "ssh_connection_command" {
  description = "SSH command to connect to the VM instance"
  value       = "ssh ${var.ssh_user}@${google_compute_instance.app_vm.network_interface[0].access_config[0].nat_ip}"
}

# ==============================
# Security & Configuration
# ==============================

output "sql_instance_settings" {
  description = "Cloud SQL instance configuration settings"
  value = {
    tier                = google_sql_database_instance.pg_private.settings[0].tier
    availability_type   = google_sql_database_instance.pg_private.settings[0].availability_type
    disk_size          = google_sql_database_instance.pg_private.settings[0].disk_size
    disk_type          = google_sql_database_instance.pg_private.settings[0].disk_type
    backup_enabled     = google_sql_database_instance.pg_private.settings[0].backup_configuration[0].enabled
    binary_log_enabled = google_sql_database_instance.pg_private.settings[0].backup_configuration[0].binary_log_enabled
  }
}

output "network_configuration" {
  description = "Network configuration summary"
  value = {
    vpc_name           = google_compute_network.vpc.name
    subnet_name        = google_compute_subnetwork.subnet.name
    subnet_cidr        = google_compute_subnetwork.subnet.ip_cidr_range
    private_range_cidr = "${google_compute_global_address.private_range.address}/${google_compute_global_address.private_range.prefix_length}"
    region             = var.region
    zone               = var.zone
  }
}

# ==============================
# Project Information
# ==============================

output "project_id" {
  description = "GCP Project ID"
  value       = var.project_id
}

output "region" {
  description = "GCP Region"
  value       = var.region
}

output "zone" {
  description = "GCP Zone"
  value       = var.zone
}