############################################
# Instance template
############################################
# Startup script: installs deps, pulls binary from GCS, installs as systemd service, exposes /healthz
locals {
  startup_script = <<-EOT
    #!/usr/bin/env bash
    set -euxo pipefail

    # Basic deps
    apt-get update
    apt-get install -y curl ca-certificates

    # Install Google Cloud Ops Agent for logs/metrics (optional but recommended)
    curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
    bash add-google-cloud-ops-agent-repo.sh --also-install

    # Fetch app binary from GCS
    install -d -m 0755 /opt/techspire
    gsutil cp "${var.binary_gcs_url}" /opt/techspire/app
    chmod +x /opt/techspire/app

    # Create a simple health endpoint using busybox httpd if your app doesn't serve /healthz
    # (If your app already exposes /healthz on 80, remove the block below.)
    apt-get install -y busybox-static || true
    cat >/opt/techspire/healthz.sh <<'HS'
    #!/usr/bin/env bash
    exec busybox httpd -f -p 0.0.0.0:80 -h /var/www/html
    HS
    chmod +x /opt/techspire/healthz.sh
    mkdir -p /var/www/html
    echo "ok" > /var/www/html/healthz
    ln -sf /var/www/html/healthz /var/www/html/index.html

    # Systemd unit for your app (listens on :8080, adjust as needed)
    cat >/etc/systemd/system/techspire.service <<'UNIT'
    [Unit]
    Description=TechSpire Performance Monitor
    After=network-online.target
    Wants=network-online.target

    [Service]
    Type=simple
    ExecStart=/opt/techspire/app --port=8080
    Restart=always
    RestartSec=5
    LimitNOFILE=65535
    Environment=PORT=8080

    [Install]
    WantedBy=multi-user.target
    UNIT

    # Health sidecar (remove if your app serves /healthz itself)
    cat >/etc/systemd/system/healthz.service <<'UNIT'
    [Unit]
    Description=Simple /healthz endpoint on :80
    After=network-online.target
    Wants=network-online.target

    [Service]
    Type=simple
    ExecStart=/opt/techspire/healthz.sh
    Restart=always
    RestartSec=5

    [Install]
    WantedBy=multi-user.target
    UNIT

    systemctl daemon-reload
    systemctl enable techspire.service
    systemctl start techspire.service
    systemctl enable healthz.service
    systemctl start healthz.service
  EOT
}

resource "google_compute_instance_template" "tpl" {
  name_prefix  = "${var.mig_name}-tpl-"
  machine_type = var.machine_type
  tags         = ["${var.mig_name}-vm"]

  disk {
    source_image = "projects/debian-cloud/global/images/family/debian-12"
    auto_delete  = true
    boot         = true
    disk_size_gb = 20
    type         = "pd-balanced"
  }

  network_interface {
    network = data.google_compute_network.default.id
    access_config {} # ephemeral public IP; remove if using NAT
  }

  metadata = {
    startup-script = local.startup_script
  }

  service_account {
    email  = var.instance_sa_email != null ? var.instance_sa_email : "default"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  lifecycle {
    create_before_destroy = true
  }
}

############################################
# Regional Managed Instance Group (MIG)
############################################
# resource "google_compute_region_instance_group_manager" "mig" {
#   name               = var.mig_name
#   base_instance_name = "${var.mig_name}-vm"
#   region             = var.region

#   versions {
#     instance_template = google_compute_instance_template.tpl.self_link
#   }

#   target_size = var.min_replicas

#   distribution_policy_zones = var.zones

#   auto_healing_policies {
#     health_check      = google_compute_health_check.http.self_link
#     initial_delay_sec = 60  # give startup script a little time
#   }

#   update_policy {
#     type                         = "PROACTIVE"
#     minimal_action               = "REPLACE"
#     max_surge_fixed              = 1
#     max_unavailable_fixed        = 0
#     instance_redistribution_type = "PROACTIVE"
#   }
# }

# ############################################
# # Autoscaler (CPU-based)
# ############################################
# resource "google_compute_region_autoscaler" "asg" {
#   name   = "${var.mig_name}-autoscaler"
#   region = var.region
#   target = google_compute_region_instance_group_manager.mig.id

#   autoscaling_policy {
#     min_replicas = var.min_replicas
#     max_replicas = var.max_replicas

#     cpu_utilization {
#       target = var.target_cpu
#     }

#     cooldown_period = var.cooldown_s
#     mode            = "ON"
#   }
# }