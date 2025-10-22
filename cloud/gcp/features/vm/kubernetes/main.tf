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
# Allow SSH to instances tagged "ssh"
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.ssh_cidr]   # e.g. your IP/CIDR; 0.0.0.0/0 for quick test
  target_tags   = var.ssh_tags

  depends_on = [google_project_service.compute]
}

# Allow HTTP (port 80) to instances tagged with var.http_tags
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["30361"]
  }

  # For public web traffic keep 0.0.0.0/0; tighten if needed
  source_ranges = [var.http_cidr]

  # Apply to VMs that have these network tags
  target_tags = var.http_tags

  depends_on = [google_project_service.compute]
}

#######################
# VM Instance
#######################
resource "google_compute_instance" "vm" {
  for_each = toset(var.vm_names)

  name         = each.value
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = var.startup_script
  depends_on              = [google_project_service.compute]
}
