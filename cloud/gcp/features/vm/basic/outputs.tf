output "external_ip" {
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
  description = "Public IP of the VM"
}

output "internal_ip" {
  value       = google_compute_instance.vm.network_interface[0].network_ip
  description = "Private/Internal IP of the VM"
}

output "vm_name" {
  value       = google_compute_instance.vm.name
  description = "Name of the VM instance"
}

output "vm_zone" {
  value       = google_compute_instance.vm.zone
  description = "Zone where the VM is deployed"
}

output "vm_machine_type" {
  value       = google_compute_instance.vm.machine_type
  description = "Machine type of the VM instance"
}

output "vm_self_link" {
  value       = google_compute_instance.vm.self_link
  description = "Self-link of the VM instance"
}

output "ssh_connection_command" {
  value       = "gcloud compute ssh ${google_compute_instance.vm.name} --zone=${google_compute_instance.vm.zone}"
  description = "Command to SSH into the VM using gcloud"
}

output "web_url" {
  value       = "http://${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}"
  description = "URL to access the web server (nginx) on the VM"
}