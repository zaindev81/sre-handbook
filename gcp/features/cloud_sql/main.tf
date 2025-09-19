resource "google_sql_database_instance" "pg" {
  name             = "demo-pg"
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = "db-custom-1-3840"    # 1vCPU / 3.75GB
    ip_configuration {
      ipv4_enabled = true        # Public IP
      authorized_networks {
        name  = "myip"
        value = "0.0.0.0/0"      # in development
      }
    }
    backup_configuration {
      enabled = true
    }
  }

  deletion_protection = false     # in development
}

resource "google_sql_database" "appdb" {
  name     = "appdb"
  instance = google_sql_database_instance.pg.name
}

resource "google_sql_user" "app" {
  name     = var.db_user
  instance = google_sql_database_instance.pg.name
  password = var.db_pass
}
