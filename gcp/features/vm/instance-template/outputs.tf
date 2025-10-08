############################################
# Helpful outputs
############################################
output "mig_name"      { value = google_compute_region_instance_group_manager.mig.name }
output "instance_group" { value = google_compute_region_instance_group_manager.mig.instance_group }
output "health_check"   { value = google_compute_health_check.http.name }
