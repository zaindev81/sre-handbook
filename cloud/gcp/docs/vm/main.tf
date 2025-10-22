#######################
# VM Instance
#######################
resource "google_compute_instance" "vm" {
  name         = "var.vm_name"
  machine_type = "var.machine_type"
  zone         = "var.zone"
  tags = ["ssh", "http"]

  # Every VM needs a boot disk —
  # this is the virtual disk that contains the operating system (OS)
  # that your VM uses to start (boot) and run.
  boot_disk {
    # Boots from Debian 12 image, 10 GB disk, Balanced PD (cost/perf middle ground).
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-12"
      size  = 10 # how large the disk is
      type  = "pd-balanced" # what disk type to use (performance level)
    }
  }

  # This defines how your VM connects to the network — both internal (VPC) and external (Internet).
  network_interface {
    # This attaches the VM to the default VPC network that every GCP project has automatically.
    network = "default"

    # Ephemeral external IP (comment out for private-only)
    # access_config {} gives the VM an ephemeral external IP (public).
    # Remove this block for private-only; then use IAP or Cloud NAT to reach the VM.
    # “Give my VM a public (external) IP address, so I can SSH or HTTP from the Internet.”
    access_config {}
  }

   # This block defines how the VM connects to the network — both internal and external.
   # Each VM needs at least one network_interface, which connects it to a VPC network or subnetwork.
  network_interface {
    # So the VM will join this specific subnetwork, and therefore get an internal IP address from that subnet’s CIDR range.
    subnetwork   = google_compute_subnetwork.subnet.id

    # This section controls external (public) access.
    # Without this block, your VM only has an internal IP and can’t be accessed directly from the internet.
    access_config {
      # Assigns static external IP
      nat_ip = google_compute_address.vm_ip.address
    }
  }


  network_interface {
    # if you don't have access_config, vm doesn't access to internet
    # you can use Cloud NAT to allow outbound internet access for private VMs
  }

  # OS Login is convenient & safer than SSH keys in metadata
  # Enables OS Login: SSH users are controlled via IAM instead of static SSH keys.
  # OS Login lets you manage SSH access via IAM roles, not static SSH keys in metadata.
  # You control access via IAM roles like:
  # roles/compute.osLogin
  # roles/compute.osAdminLogin
  # vim ~/.ssh/google_compute_known_hosts
  # vim ~/.ssh/google_compute_engine
  metadata = {
    enable-oslogin = "TRUE"
  }

  # ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  metadata = {
    ssh-keys = "terraform:${file(var.ssh_key_path)}"
  }

  # Optional startup script (install nginx as example)
  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "Hello from Terraform VM with Nginx!" > /var/www/html/index.nginx-debian.html
  EOT

  depends_on = [google_project_service.compute]
}