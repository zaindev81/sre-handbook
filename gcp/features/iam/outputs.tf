# Output the service account email
output "service_account_email" {
  description = "The email address of the created service account."
  value       = google_service_account.terraform_sa.email
}

# Output the full name (unique identifier) of the service account
output "service_account_name" {
  description = "The fully qualified name of the service account."
  value       = google_service_account.terraform_sa.name
}

# Output the IAM role assigned to the service account
output "assigned_role" {
  description = "The role assigned to the service account."
  value       = google_project_iam_member.sa_role.role
}
