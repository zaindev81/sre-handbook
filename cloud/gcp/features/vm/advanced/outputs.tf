# VM Instance Outputs
output "vm_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.web_vm.name
}

output "vm_id" {
  description = "ID of the VM instance"
  value       = google_compute_instance.web_vm.id
}

output "vm_external_ip" {
  description = "Static external IP address of the VM"
  value       = google_compute_address.vm_ip.address
}

output "vm_internal_ip" {
  description = "Internal IP address of the VM"
  value       = google_compute_instance.web_vm.network_interface[0].network_ip
}

output "vm_zone" {
  description = "Zone where the VM is deployed"
  value       = google_compute_instance.web_vm.zone
}

output "vm_machine_type" {
  description = "Machine type of the VM"
  value       = google_compute_instance.web_vm.machine_type
}

output "vm_self_link" {
  description = "Self link of the VM instance"
  value       = google_compute_instance.web_vm.self_link
}

# Network Outputs
output "vpc_name" {
  description = "Name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "vpc_id" {
  description = "ID of the VPC network"
  value       = google_compute_network.vpc_network.id
}

output "vpc_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_cidr" {
  description = "CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "subnet_region" {
  description = "Region of the subnet"
  value       = google_compute_subnetwork.subnet.region
}

# Static IP Output
output "static_ip_address" {
  description = "Reserved static IP address"
  value       = google_compute_address.vm_ip.address
}

output "static_ip_name" {
  description = "Name of the static IP resource"
  value       = google_compute_address.vm_ip.name
}

# Firewall Outputs
output "firewall_rule_name" {
  description = "Name of the firewall rule"
  value       = google_compute_firewall.allow_ssh_http.name
}

output "firewall_rule_id" {
  description = "ID of the firewall rule"
  value       = google_compute_firewall.allow_ssh_http.id
}

output "web_url" {
  description = "HTTP URL to access the web server"
  value       = "http://${google_compute_address.vm_ip.address}"
}

# Summary Output
output "vm_summary" {
  description = "Summary of VM configuration"
  value = {
    name         = google_compute_instance.web_vm.name
    external_ip  = google_compute_address.vm_ip.address
    internal_ip  = google_compute_instance.web_vm.network_interface[0].network_ip
    zone         = google_compute_instance.web_vm.zone
    machine_type = google_compute_instance.web_vm.machine_type
    vpc_network  = google_compute_network.vpc_network.name
    subnet       = google_compute_subnetwork.subnet.name
  }
}