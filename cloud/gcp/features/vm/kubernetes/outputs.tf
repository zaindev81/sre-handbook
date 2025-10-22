#######################
# VM Instance Outputs
#######################
output "vm_instances" {
  description = "Details of all VM instances"
  value = {
    for k, v in google_compute_instance.vm : k => {
      name         = v.name
      machine_type = v.machine_type
      zone         = v.zone
      status       = v.current_status
      tags         = v.tags
    }
  }
}

output "vm_names" {
  description = "List of VM instance names"
  value       = [for vm in google_compute_instance.vm : vm.name]
}

output "vm_internal_ips" {
  description = "Internal IP addresses of VM instances"
  value = {
    for k, v in google_compute_instance.vm : k => v.network_interface[0].network_ip
  }
}

output "vm_external_ips" {
  description = "External IP addresses of VM instances"
  value = {
    for k, v in google_compute_instance.vm : k => v.network_interface[0].access_config[0].nat_ip
  }
}

output "vm_self_links" {
  description = "Self links of VM instances"
  value = {
    for k, v in google_compute_instance.vm : k => v.self_link
  }
}

#######################
# Firewall Outputs
#######################
output "ssh_firewall_rule" {
  description = "SSH firewall rule details"
  value = {
    name          = google_compute_firewall.allow_ssh.name
    network       = google_compute_firewall.allow_ssh.network
    source_ranges = google_compute_firewall.allow_ssh.source_ranges
    target_tags   = google_compute_firewall.allow_ssh.target_tags
  }
}

output "http_firewall_rule" {
  description = "HTTP firewall rule details"
  value = {
    name          = google_compute_firewall.allow_http.name
    network       = google_compute_firewall.allow_http.network
    source_ranges = google_compute_firewall.allow_http.source_ranges
    target_tags   = google_compute_firewall.allow_http.target_tags
    allowed_ports = [
      for allow in google_compute_firewall.allow_http.allow : allow.ports
    ]
  }
}

#######################
# SSH Connection Strings
#######################
output "ssh_commands" {
  description = "SSH commands to connect to VM instances"
  value = {
    for k, v in google_compute_instance.vm : k => "gcloud compute ssh ${v.name} --zone=${v.zone}"
  }
}

#######################
# Kubernetes-specific Outputs
#######################
output "kubernetes_cluster_ips" {
  description = "IP addresses for potential Kubernetes cluster setup"
  value = {
    master_nodes = [
      for k, v in google_compute_instance.vm : v.network_interface[0].network_ip
      if can(regex("master|control", k))
    ]
    worker_nodes = [
      for k, v in google_compute_instance.vm : v.network_interface[0].network_ip
      if !can(regex("master|control", k))
    ]
    all_nodes = [
      for v in google_compute_instance.vm : v.network_interface[0].network_ip
    ]
  }
}

output "nodeport_service_urls" {
  description = "URLs for NodePort services (port 30361 is exposed in firewall)"
  value = {
    for k, v in google_compute_instance.vm : k => "http://${v.network_interface[0].access_config[0].nat_ip}:30361"
  }
}

#######################
# Project and Service Outputs
#######################
output "compute_api_status" {
  description = "Status of the Compute Engine API"
  value = {
    service = google_project_service.compute.service
    project = google_project_service.compute.project
  }
}
