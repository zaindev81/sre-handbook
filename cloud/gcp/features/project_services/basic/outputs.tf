# What the module actually enabled
output "enabled_apis" {
  description = "APIs enabled in the project by the module"
  value       = module.project-services.enabled_apis
}

output "enabled_api_identities" {
  description = "API identities enabled/created by the module"
  value       = module.project-services.enabled_api_identities
}

# (Optional) Echo your inputs at the root, if you want them in `terraform output`
output "requested_activate_apis" {
  description = "APIs requested to be enabled (input)"
  value       = var.activate_apis
}