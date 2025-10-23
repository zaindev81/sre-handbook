#######################
# Enable API
#######################
resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

#######################
# Firewall
#######################
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-web"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}

#######################
# Load Balancer
#######################

# ---------- Backend Service ----------
resource "google_compute_region_backend_service" "web" {
  name                  = "web-backend"
  region                = var.region
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group           = google_compute_region_instance_group_manager.web.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_region_health_check.http.id]
}

# ---------- URL Map ----------
resource "google_compute_region_url_map" "web" {
  name            = "web-urlmap"
  region          = var.region
  default_service = google_compute_region_backend_service.web.id
}

# ---------- HTTP Proxy ----------
resource "google_compute_region_target_http_proxy" "web" {
  name    = "web-proxy"
  region  = var.region
  url_map = google_compute_region_url_map.web.id
}

# ---------- Forwarding Rule (External IP) ----------
resource "google_compute_forwarding_rule" "web" {
  name                  = "web-forwarding-rule"
  region                = var.region
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.web.id

  depends_on = [google_compute_subnetwork.proxy_only]
}

# Proxy-only Subnet (Required for EXTERNAL_MANAGED LB)
resource "google_compute_subnetwork" "proxy_only" {
  name          = "proxy-only-subnet"
   ip_cidr_range = "10.1.0.0/23" # Small subnet for proxy-only
  region        = var.region
  network       = "default"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

#######################
# Managed Instance
#######################
# ---------- Health check (for autohealing) ----------
resource "google_compute_region_health_check" "http" {
  name               = "mig-http-hc"
  region             = var.region
  timeout_sec        = 5
  check_interval_sec = 10

  http_health_check {
    port = 80
    request_path = "/"
  }
}

# ---------- Instance Template ----------
resource "google_compute_instance_template" "web" {
  name_prefix  = "web-tpl-"
  machine_type = "e2-micro"

  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
    access_config {} // Ephemeral public IP
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    echo "Hello from MIG instance $(hostname)" > /var/www/html/index.nginx-debian.html
    systemctl enable nginx --now
  EOT

  # if you want to run a dockerized app, use something like this instead:
  # metadata_startup_script = <<-EOT
  # #!/bin/bash
  # apt-get update
  # apt-get install -y docker.io
  # systemctl start docker

  # run -d -p 80:3000 ghcr.io/your-repo/backend:latest
  # EOT

  tags = ["web"]

  lifecycle {
    create_before_destroy = true
  }
}

# ---------- Regional Managed Instance Group ----------
resource "google_compute_region_instance_group_manager" "web" {
  name               = "web-mig"
  base_instance_name = "web"
  region             = var.region

  version {
    instance_template = google_compute_instance_template.web.id
    # name              = "primary"
  }

  # target_size = var.mig_size // you dont need to set this when using autoscaler

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.http.id
    initial_delay_sec = 60
  }

  # Safe rolling updates when template changes
  update_policy {
    type                           = "PROACTIVE" // start rolling update as soon as template changes
    minimal_action                 = "REPLACE"
    most_disruptive_allowed_action = "REPLACE"
    max_unavailable_fixed          = 0
    max_surge_fixed                = 3    # allow up to 3 extra instances during update
  }
}

# ---------- Autoscaler (CPU target ~60%) ----------
resource "google_compute_region_autoscaler" "web" {
  name   = "web-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.web.id

  autoscaling_policy {
    min_replicas = 2
    max_replicas = 6
    cpu_utilization {
      target = 0.60
    }
    cooldown_period = 60
  }
}
