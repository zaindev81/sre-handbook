# ----------------------
# Compute Engine VM
# ----------------------
resource "google_compute_instance" "app_vm" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

    # expose a public IP for SSH access
    access_config {}
  }

  # Metadata for SSH keys
  metadata = {
    # Format: "username:ssh-rsa <public-key>"
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  # Tags for firewall rules, etc.
  tags = var.vm_tags

  depends_on = [
    google_sql_database_instance.pg_private
  ]
}
