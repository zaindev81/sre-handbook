# In Google Cloud Platform (GCP), a service account name usually refers to the email address of the service account.
# It uniquely identifies the service account in your GCP project.
# terraform-admin@<your-project-id>.iam.gserviceaccount.com

# Create a Service Account
resource "google_service_account" "terraform_sa" {
  account_id   = var.account_id
  display_name = var.display_name
}

# Assign Roles to the Service Account
resource "google_project_iam_member" "sa_role" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}

# Generate Service Account Key (for external systems)
# resource "google_service_account_key" "terraform_sa_key" {
#   service_account_id = google_service_account.terraform_sa.name
# }

# Custom IAM Role
# resource "google_project_iam_custom_role" "custom_role" {
#   role_id     = "customStorageRole"
#   title       = "Custom Storage Role"
#   description = "Custom role with limited storage permissions"
#   project     = var.project_id

#   permissions = [
#     "storage.buckets.get",
#     "storage.objects.list",
#     "storage.objects.get",
#   ]
# }

# resource "google_project_iam_member" "sa_custom_role" {
#   project = var.project_id
#   role    = google_project_iam_custom_role.custom_role.name
#   member  = "serviceAccount:${google_service_account.terraform_sa.email}"
# }

# Multiple Role Bindings
# resource "google_project_iam_binding" "multiple_roles" {
#   project = var.project_id
#   role    = "roles/storage.admin"

#   members = [
#     "serviceAccount:${google_service_account.terraform_sa.email}",
#     "user:admin@example.com"
#   ]
# }

# Organization-Level IAM
# resource "google_organization_iam_member" "org_admin" {
#   org_id = var.org_id
#   role   = "roles/resourcemanager.organizationAdmin"
#   member = "serviceAccount:${google_service_account.terraform_sa.email}"
# }

# Secret Manager for Key Storage
# resource "google_secret_manager_secret" "sa_secret" {
#   secret_id = "terraform-sa-key"
#   replication {
#     automatic = true
#   }
# }

# resource "google_secret_manager_secret_version" "sa_secret_version" {
#   secret      = google_secret_manager_secret.sa_secret.id
#   secret_data = google_service_account_key.terraform_sa_key.private_key
# }