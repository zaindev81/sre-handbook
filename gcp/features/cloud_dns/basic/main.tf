#######################
# Enable API
#######################
resource "google_project_service" "dns" {
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

#######################
# Cloud DNS Managed Zone & Records
#######################

# 1. Please register nameservers at your domain registrar (e.g., GoDaddy, Namecheap, Cloudflare)

# Public Zone (e.g., example.com)
# apex = zone apex / root domain / naked domain / bare domain
resource "google_dns_managed_zone" "public" {
  name        = "example-com"
  dns_name    = "${var.root_domain}."   # "example.com."
  description = "Public zone for ${var.root_domain}"
  visibility  = "public"

  # Optional: DNSSEC
  dnssec_config { state = "on" }

  depends_on = [google_project_service.dns]
}

# APEX A/AAAA
resource "google_dns_record_set" "apex_a" {
  managed_zone = google_dns_managed_zone.public.name
  name         = "${var.root_domain}."
  type         = "A"
  ttl          = 300
  rrdatas      = [var.apex_ipv4]
}

# resource "google_dns_record_set" "apex_aaaa" {
#   count        = var.apex_ipv6 != null ? 1 : 0
#   managed_zone = google_dns_managed_zone.public.name
#   name         = "${var.root_domain}."
#   type         = "AAAA"
#   ttl          = 300
#   rrdatas      = [var.apex_ipv6]
# }

# # www → APEX
# resource "google_dns_record_set" "www_cname" {
#   managed_zone = google_dns_managed_zone.public.name
#   name         = "www.${var.root_domain}."
#   type         = "CNAME"
#   ttl          = 300
#   rrdatas      = ["${var.root_domain}."]
# }

# # TXT (example: SPF or verification)
# resource "google_dns_record_set" "spf_txt" {
#   managed_zone = google_dns_managed_zone.public.name
#   name         = "${var.root_domain}."
#   type         = "TXT"
#   ttl          = 300
#   rrdatas      = ["v=spf1 -all"]
# }

# # MX (example: Gmail)
# resource "google_dns_record_set" "mx" {
#   managed_zone = google_dns_managed_zone.public.name
#   name         = "${var.root_domain}."
#   type         = "MX"
#   ttl          = 300
#   rrdatas      = [
#     "1 aspmx.l.google.com.",
#     "5 alt1.aspmx.l.google.com.",
#     "5 alt2.aspmx.l.google.com.",
#     "10 alt3.aspmx.l.google.com.",
#     "10 alt4.aspmx.l.google.com."
#   ]
# }

# Get an existing VPC (example: "default")
# data "google_compute_network" "vpc" {
#   name = "default"
# }

# resource "google_dns_managed_zone" "private" {
#   name        = "corp-example-com"
#   dns_name    = "corp.${var.root_domain}."
#   visibility  = "private"
#   description = "Private zone for corp.${var.root_domain}"

#   private_visibility_config {
#     networks { network_url = data.google_compute_network.vpc.self_link }
#   }
# }

# resource "google_dns_record_set" "svc_a" {
#   managed_zone = google_dns_managed_zone.private.name
#   name         = "api.corp.${var.root_domain}."
#   type         = "A"
#   ttl          = 60
#   rrdatas      = ["10.0.0.10"]
# }

# Optional: wildcard & split-horizon
# resource "google_dns_record_set" "wildcard" {
#   managed_zone = google_dns_managed_zone.public.name
#   name         = "*.${var.root_domain}."
#   type         = "CNAME"
#   ttl          = 300
#   rrdatas      = ["${var.root_domain}."]
# }
