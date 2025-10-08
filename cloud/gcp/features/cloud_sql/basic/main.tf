resource "google_sql_database_instance" "pg" {
  name             = var.db_instance_name
  database_version = var.db_version
  region           = var.region

  settings {
    tier = var.db_tier

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
  name     = var.db_name
  instance = google_sql_database_instance.pg.name
}

resource "google_sql_user" "app" {
  name     = var.db_user
  instance = google_sql_database_instance.pg.name
  password = var.db_pass
}
