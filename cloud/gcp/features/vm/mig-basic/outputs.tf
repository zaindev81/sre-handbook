# ---------- Load Balancer IP ----------
output "load_balancer_ip" {
  description = "External IP address of the load balancer"
  value       = google_compute_forwarding_rule.web.ip_address
}

# ---------- Load Balancer URL ----------
output "load_balancer_url" {
  description = "URL to access the load balancer"
  value       = "http://${google_compute_forwarding_rule.web.ip_address}"
}

# ---------- MIG Details ----------
output "mig_name" {
  description = "Name of the managed instance group"
  value       = google_compute_region_instance_group_manager.web.name
}

output "mig_self_link" {
  description = "Self link of the managed instance group"
  value       = google_compute_region_instance_group_manager.web.self_link
}

output "mig_instance_group" {
  description = "Instance group URL"
  value       = google_compute_region_instance_group_manager.web.instance_group
}

# ---------- Autoscaler Details ----------
output "autoscaler_name" {
  description = "Name of the autoscaler"
  value       = google_compute_region_autoscaler.web.name
}

output "autoscaler_min_replicas" {
  description = "Minimum number of replicas"
  value       = google_compute_region_autoscaler.web.autoscaling_policy[0].min_replicas
}

output "autoscaler_max_replicas" {
  description = "Maximum number of replicas"
  value       = google_compute_region_autoscaler.web.autoscaling_policy[0].max_replicas
}

# ---------- Health Check ----------
output "health_check_name" {
  description = "Name of the health check"
  value       = google_compute_region_health_check.http.name
}

# ---------- Backend Service ----------
output "backend_service_name" {
  description = "Name of the backend service"
  value       = google_compute_region_backend_service.web.name
}

# ---------- Region ----------
output "region" {
  description = "Region where resources are deployed"
  value       = var.region
}