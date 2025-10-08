############################################
# Networking (use default network or bring your own)
############################################
data "google_compute_network" "default" {
  name = "default"
}

# Allow inbound HTTP for health check / optional metrics endpoint
resource "google_compute_firewall" "allow_http" {
  name    = "${var.mig_name}-allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.mig_name}-vm"]
}
