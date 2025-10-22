# resource "google_compute_image" "custom_image" {
#   name = "custom-vm-image"
#   source_disk = google_compute_instance.base_vm.boot_disk[0].source
# }

########################
# Enable OS Login at the project level
########################
# resource "google_compute_project_metadata_item" "enable_oslogin" {
#   key   = "enable-oslogin"
#   value = "TRUE"
# }

# my account
# resource "google_project_iam_member" "os_login_user" {
#   project = var.project_id
#   role    = "roles/compute.osLogin"
#   member  = "user:dummy@example.com"
# }
