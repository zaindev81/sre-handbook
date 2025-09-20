# ----------------------
# VPC & Subnetwork
# ----------------------
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Like subnet in AWS, VLAN in on-prem
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

# ----------------------
# Private IP for Cloud SQL
# ----------------------
# This resource is used to reserve an internal IP address range
# in the VPC specifically for Google-managed services through Private Services Access (PSA).
# It is required when you want to use Cloud SQL with a private IP.

# purpose = "VPC_PEERING"
# Indicates that this is a reserved range for Private Services Access (PSA).
# Its purpose is different from a regular static IP address.

# address_type = "INTERNAL"
# Reserves a private (internal) IP address range.
resource "google_compute_global_address" "private_range" {
  name          = var.private_range_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16 # /16 => 65,536 IP
  network       = google_compute_network.vpc.id

  depends_on = [google_compute_network.vpc]
}

# Create a **Service Networking connection** ← This resource
# → **Privately connects** the VPC with **Google-managed services**.

# reserved_peering_ranges = [google_compute_global_address.private_range.name]
# Specify the name of the Cloud SQL–dedicated IP range that you reserved earlier with google_compute_global_address.
# This range will be used on the Google side.
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com" # Specify the target service for the connection.
  reserved_peering_ranges = [google_compute_global_address.private_range.name]

  depends_on = [google_compute_global_address.private_range]
}

resource "google_compute_firewall" "allow_ssh_from_me" {
  name    = "allow-ssh-from-me"
  network = google_compute_network.vpc.name
  direction     = "INGRESS"
  source_ranges = [var.my_ip_cidr]
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  # target_tags = [var.firewall_target_tag]

  depends_on = [google_compute_network.vpc]
}