# -------- Enable required APIs --------
resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "iamcredentials.googleapis.com",
  ])
  project = var.project_id
  service = each.key
}

# -------- VPC Network --------
# VPC / Subnet (VPC-native: secondary range required)
resource "google_compute_network" "vpc" {
  name                    = "gke-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  ip_cidr_range = "10.10.0.0/20"
  region        = var.region
  network       = google_compute_network.vpc.id

  # Pod/Service Secondary Range
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.11.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.12.0.0/20"
  }
}

# Purpose: This is the OS/service account used by GKE nodes (the VM instances).
# Why these roles: Nodes must be able to ship logs and metrics to Cloud Logging/Monitoring. Keeping only these 2 roles follows least privilege.
# Service account for nodes (grant minimal permissions as needed)
resource "google_service_account" "nodes" {
  account_id   = "gke-nodes-sa"
  display_name = "GKE nodes service account"
}

# Common roles (minimize permissions based on your environment)
resource "google_project_iam_member" "nodes_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.nodes.email}"
}

resource "google_project_iam_member" "nodes_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.nodes.email}"
}

# -------- Enable required APIs --------
# Standard Cluster
resource "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.region

  network    = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet.id

  # VPC-native (IP aliasing)
  # Required for modern GKE
  # This allows scalable IP management and avoids IP conflicts.
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # Release channel (REGULAR is a safe choice)
#   A stable, general-availability channel. (RAPID = newest, STABLE = conservative. REGULAR is a safe, balanced choice.)
  release_channel { channel = "REGULAR" }

  # Add control plane authentication or network controls if needed
  # : Creates the cluster without the default node pool so you can attach your own with your desired settings (machine type, labels, SA, etc.).
  remove_default_node_pool = true
  initial_node_count       = 1

  # enables GKE’s identity federation.
  # Benefit: Pods can impersonate GSAs via KSA bindings—no JSON keys in Secrets. This is the recommended way to let Pods call Google APIs.
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  deletion_protection = false

  depends_on = [
    google_project_service.services,
    google_compute_subnetwork.subnet
  ]
}

# Node pool (controls machine type, etc.)
resource "google_container_node_pool" "default_pool" {
  name       = "default-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster.name

  # You’ll get 2 nodes per region spread (GKE will spread across zones). Two nodes are the practical minimum for tolerating disruptions during upgrades.
  node_count = 2

  node_config {
    # machine_type = "e2-medium"
    machine_type = "e2-micro"
    service_account = google_service_account.nodes.email

    disk_size_gb = 10
    disk_type    = "pd-standard" # or "pd-balanced"

    # Grants broad OAuth scope to the node VMs. This is standard, but your Pod access should still be restricted via Workload Identity and IAM on the target GSAs—so the broad scope alone doesn’t give Pods carte blanche.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Simple topology/role labeling—handy for scheduling or inventory.
    labels = {
      role = "general"
    }

    # Security best practice. Disables legacy metadata endpoints (reduces SSRF risks).
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  # Auto-upgrade keeps node images/Kubernetes minor versions updated safely.
  # Auto-repair recreates unhealthy nodes automatically.
  management {
    auto_upgrade = true
    auto_repair  = true
  }
}