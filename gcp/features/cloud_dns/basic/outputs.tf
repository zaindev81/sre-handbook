output "nameservers" {
  value       = google_dns_managed_zone.public.name_servers
  description = "Set these at your domain registrar. without the trailing dot."
}