# terraform {
#   required_version = ">= 1.6.0"
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 5.41"
#     }
#   }
# }

# provider "google" {
#   project = var.project_id
#   region  = var.region
# }

# #######################
# # Enable API
# #######################
# resource "google_project_service" "compute" {
#   service            = "compute.googleapis.com"
#   disable_on_destroy = false
# }

# #######################
# # Firewall (minimal)
# #######################
# # SSH
# resource "google_compute_firewall" "allow_ssh" {
#   name    = "allow-ssh"
#   network = "default"
#   allow { protocol = "tcp" ports = ["22"] }
#   source_ranges = [var.ssh_cidr]
#   target_tags   = ["ssh"]
#   depends_on    = [google_project_service.compute]
# }

# # Kubernetes API (port 6443)
# # Accessible within the VPC. For testing purposes, you can allow external access,
# # but this is not recommended for production.
# resource "google_compute_firewall" "allow_k8s_api" {
#   name    = "allow-k8s-api"
#   network = "default"
#   allow { protocol = "tcp" ports = ["6443"] }
#   source_ranges = [var.ssh_cidr] # Simplified for testing; narrow CIDR as needed
#   target_tags   = ["k8s-cp"]
# }

# # Node-to-node communication (for flannel: 8285/8472, minimal configuration)
# resource "google_compute_firewall" "allow_k8s_nodes" {
#   name    = "allow-k8s-nodes"
#   network = "default"
#   allow {
#     protocol = "tcp"
#     ports    = ["10250","10255","30000-32767"] # kubelet / metrics / NodePort
#   }
#   allow { protocol = "udp" ports = ["8472","8285"] } # vxlan / flannel
#   source_ranges = ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12"] # within VPC
#   target_tags   = ["k8s-node","k8s-cp"]
# }

# #######################
# # Control Plane VM (single)
# #######################
# resource "google_compute_instance" "k8s_cp" {
#   name         = "k8s-cp-1"
#   machine_type = var.cp_machine_type
#   zone         = var.zones[0]
#   tags         = ["ssh","k8s-cp","k8s-node"]

#   boot_disk {
#     initialize_params {
#       image = "projects/debian-cloud/global/images/family/debian-12"
#       size  = 20
#       type  = "pd-balanced"
#     }
#   }

#   network_interface {
#     network       = "default"
#     access_config {} # ephemeral external IP (for testing)
#   }

#   metadata = {
#     enable-oslogin = "TRUE"
#     pod_cidr       = var.pod_cidr
#   }

#   metadata_startup_script = <<-EOT
#     #!/bin/bash
#     set -euxo pipefail

#     # Basic setup
#     apt-get update
#     apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release socat conntrack ebtables ethtool

#     # Install containerd
#     apt-get install -y containerd
#     mkdir -p /etc/containerd
#     containerd config default > /etc/containerd/config.toml
#     systemctl enable --now containerd

#     # Disable swap (required for kubeadm)
#     swapoff -a
#     sed -i.bak '/ swap / s/^/#/' /etc/fstab

#     # Install kubeadm/kubelet/kubectl
#     curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
#     echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" > /etc/apt/sources.list.d/kubernetes.list
#     apt-get update
#     apt-get install -y kubelet kubeadm kubectl
#     apt-mark hold kubelet kubeadm kubectl

#     # Initialize kubeadm
#     POD_CIDR="$(curl -s -f -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/attributes/pod_cidr)"
#     kubeadm init --pod-network-cidr="${POD_CIDR}" --kubernetes-version "stable-1.30"

#     # Configure kubeconfig
#     mkdir -p /root/.kube
#     cp -i /etc/kubernetes/admin.conf /root/.kube/config

#     # CNI (flannel)
#     # Example: v0.25.5 manifest, update as necessary
#     kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.25.5/Documentation/kube-flannel.yml

#     # Output join command for workers
#     kubeadm token create --print-join-command > /root/join.sh
#     chmod +x /root/join.sh
#     echo "==== RUN THIS ON WORKERS ===="
#     cat /root/join.sh
#   EOT

#   depends_on = [
#     google_project_service.compute,
#     google_compute_firewall.allow_ssh,
#     google_compute_firewall.allow_k8s_api,
#     google_compute_firewall.allow_k8s_nodes
#   ]
# }

# output "cp_external_ip" {
#   value = google_compute_instance.k8s_cp.network_interface[0].access_config[0].nat_ip
# }

# #######################
# # Worker Instance Template (for MIG)
# #######################
# resource "google_compute_instance_template" "k8s_worker_tpl" {
#   name         = "k8s-worker-tpl"
#   machine_type = var.wk_machine_type
#   tags         = ["ssh","k8s-node"]

#   disk {
#     auto_delete  = true
#     boot         = true
#     source_image = "projects/debian-cloud/global/images/family/debian-12"
#     type         = "pd-balanced"
#     disk_size_gb = 20
#   }

#   network_interface {
#     network = "default"
#     access_config {} # For testing; omit external IP in production
#   }

#   metadata = {
#     enable-oslogin = "TRUE"
#     kubeadm_join   = var.kubeadm_join_command
#   }

#   metadata_startup_script = <<-EOT
#     #!/bin/bash
#     set -euxo pipefail

#     apt-get update
#     apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release socat conntrack ebtables ethtool

#     # Install containerd
#     apt-get install -y containerd
#     mkdir -p /etc/containerd
#     containerd config default > /etc/containerd/config.toml
#     systemctl enable --now containerd

#     # Disable swap
#     swapoff -a
#     sed -i.bak '/ swap / s/^/#/' /etc/fstab

#     # Install kubeadm/kubelet/kubectl
#     curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /usr/share/keyrings/kubernetes-archive-keyring.gpg
#     echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" > /etc/apt/sources.list.d/kubernetes.list
#     apt-get update
#     apt-get install -y kubelet kubeadm kubectl
#     apt-mark hold kubelet kubeadm kubectl

#     # Join the cluster
#     JOIN_CMD="$(curl -s -f -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/attributes/kubeadm_join || true)"
#     if [ -n "$JOIN_CMD" ]; then
#       for i in $(seq 1 20); do
#         if $JOIN_CMD; then
#           echo "joined successfully"
#           break
#         fi
#         echo "join failed, retrying... ($i)"
#         sleep 10
#       done
#     else
#       echo "kubeadm_join not set in metadata; skipping"
#     fi
#   EOT
# }

# #######################
# # Regional MIG (Workers)
# #######################
# resource "google_compute_region_instance_group_manager" "k8s_workers" {
#   name               = "k8s-workers"
#   base_instance_name = "k8s-wk"
#   region             = var.region
#   distribution_policy_zones = [
#     for z in var.zones : "projects/${var.project_id}/zones/${z}"
#   ]

#   version {
#     instance_template = google_compute_instance_template.k8s_worker_tpl.self_link
#   }

#   target_size = 2

#   auto_healing_policies {
#     health_check      = google_compute_health_check.basic_tcp.self_link
#     initial_delay_sec = 120
#   }
# }

# # Simple health check (port 22). Adjust for actual node health checks in production.
# resource "google_compute_health_check" "basic_tcp" {
#   name = "mig-basic-tcp"
#   tcp_health_check { port = 22 }
# }

# #######################
# # Autoscaler (Workers)
# #######################
# resource "google_compute_region_autoscaler" "k8s_workers_as" {
#   name   = "k8s-workers-as"
#   region = var.region
#   target = google_compute_region_instance_group_manager.k8s_workers.id

#   autoscaling_policy {
#     min_replicas = 2
#     max_replicas = 6
#     cpu_utilization { target = 0.6 }
#   }
# }
