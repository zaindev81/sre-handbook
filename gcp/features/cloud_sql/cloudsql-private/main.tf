# ----------------------
# Cloud SQL Instance
# ----------------------
resource "google_sql_database_instance" "pg_private" {
  name             = var.db_instance_name
  database_version = var.db_version
  region           = var.region

  settings {
    tier              = var.db_tier
    availability_type = "ZONAL" # or REGIONAL for HA

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.self_link
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day  = 7   # Sunday
      hour = 3   # 03:00 UTC
    }

    insights_config {
      query_insights_enabled  = true
      record_application_tags = true
    }
  }

  deletion_protection = var.deletion_protection

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

# ----------------------
# Cloud SQL Database
# ----------------------
resource "google_sql_database" "appdb_private" {
  name     = var.db_name
  instance = google_sql_database_instance.pg_private.name
}

# ----------------------
# Cloud SQL User
# ----------------------
resource "google_sql_user" "app_private" {
  name     = var.db_user
  instance = google_sql_database_instance.pg_private.name
  password = var.db_pass
}

# Issues
# Please remove VPC network peering connection manually if you want to destroy the infra.