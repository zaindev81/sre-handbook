# GKE Cluster Outputs
output "cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.cluster.name
}

output "cluster_location" {
  description = "The location (region or zone) of the GKE cluster"
  value       = google_container_cluster.cluster.location
}

output "cluster_endpoint" {
  description = "The IP address of the cluster master"
  value       = google_container_cluster.cluster.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate (base64 encoded)"
  value       = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_id" {
  description = "The unique identifier of the GKE cluster"
  value       = google_container_cluster.cluster.id
}

# Network Outputs
output "vpc_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.vpc.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_cidr" {
  description = "The CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "pods_secondary_range_name" {
  description = "The name of the secondary range for pods"
  value       = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
}

output "services_secondary_range_name" {
  description = "The name of the secondary range for services"
  value       = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
}

# Node Pool Outputs
output "node_pool_name" {
  description = "The name of the default node pool"
  value       = google_container_node_pool.default_pool.name
}

output "node_pool_machine_type" {
  description = "The machine type of the nodes in the default pool"
  value       = google_container_node_pool.default_pool.node_config[0].machine_type
}

output "node_pool_count" {
  description = "The number of nodes in the default pool"
  value       = google_container_node_pool.default_pool.node_count
}

# Service Account Outputs
output "nodes_service_account_email" {
  description = "The email address of the service account used by the nodes"
  value       = google_service_account.nodes.email
}

output "nodes_service_account_unique_id" {
  description = "The unique ID of the service account used by the nodes"
  value       = google_service_account.nodes.unique_id
}

# Kubectl Connection Command
output "kubectl_connection_command" {
  description = "Command to configure kubectl to connect to the cluster"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.cluster.name} --region=${google_container_cluster.cluster.location} --project=${var.project_id}"
}