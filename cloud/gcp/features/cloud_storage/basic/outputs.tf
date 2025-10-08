output "app_data_bucket_name" {
  description = "Name of the application data bucket"
  value       = google_storage_bucket.app_data.name
}

output "app_data_bucket_url" {
  description = "URL of the application data bucket"
  value       = google_storage_bucket.app_data.url
}

output "app_data_bucket_self_link" {
  description = "Self link of the application data bucket"
  value       = google_storage_bucket.app_data.self_link
}

output "logs_bucket_name" {
  description = "Name of the logs bucket"
  value       = google_storage_bucket.logs.name
}

output "logs_bucket_url" {
  description = "URL of the logs bucket"
  value       = google_storage_bucket.logs.url
}

output "logs_bucket_self_link" {
  description = "Self link of the logs bucket"
  value       = google_storage_bucket.logs.self_link
}

output "bucket_locations" {
  description = "Locations of the created buckets"
  value = {
    app_data = google_storage_bucket.app_data.location
    logs     = google_storage_bucket.logs.location
  }
}

output "bucket_storage_classes" {
  description = "Storage classes of the created buckets"
  value = {
    app_data = google_storage_bucket.app_data.storage_class
    logs     = google_storage_bucket.logs.storage_class
  }
}