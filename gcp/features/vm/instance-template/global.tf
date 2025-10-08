############################################
# Health check (HTTP on port 80 /healthz)
############################################
resource "google_compute_health_check" "http" {
  name = "${var.mig_name}-hc"

  http_health_check {
    port         = 80
    request_path = "/healthz"
  }

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
}