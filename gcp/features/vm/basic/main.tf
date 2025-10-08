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

#######################
# VM Instance
#######################
resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.ssh_tags

  boot_disk {
    # Boots from Debian 12 image, 10 GB disk, Balanced PD (cost/perf middle ground).
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
      size  = 10
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    # Ephemeral external IP (comment out for private-only)
    # access_config {} gives the VM an ephemeral external IP (public).
    # Remove this block for private-only; then use IAP or Cloud NAT to reach the VM.
    access_config {}
  }

  # OS Login is convenient & safer than SSH keys in metadata
  # Enables OS Login: SSH users are controlled via IAM instead of static SSH keys.
  metadata = {
    enable-oslogin = "TRUE"
  }

  # Optional startup script (install nginx as example)
  metadata_startup_script = var.startup_script

  depends_on = [google_project_service.compute]
}
