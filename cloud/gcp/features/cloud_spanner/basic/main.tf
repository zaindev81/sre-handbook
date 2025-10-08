#######################
# Enable API
#######################
resource "google_project_service" "spanner" {
  service            = "spanner.googleapis.com"
  disable_on_destroy = false
}

#######################
# Spanner Instance
#######################
resource "google_spanner_instance" "this" {
  name             = var.instance_name
  display_name     = var.instance_display_name
  config           = var.instance_config  # e.g. regional-us-central1
  processing_units = var.processing_units # prefer PUs over node_count (1000 PU = 1 node)

  labels = {
    env = var.env
  }

  depends_on = [google_project_service.spanner]
}

#######################
# Spanner Database
#######################
resource "google_spanner_database" "this" {
  instance = google_spanner_instance.this.name
  name     = var.database_name

  # Optional: create a simple table
  ddl = var.enable_sample_table ? [
    <<-SQL
    CREATE TABLE Users (
      UserId   STRING(36) NOT NULL,
      Name     STRING(256),
      Email    STRING(256),
      Created  TIMESTAMP OPTIONS (allow_commit_timestamp=true)
    ) PRIMARY KEY (UserId)
    SQL
  ] : []

  deletion_protection = false
}

#######################
# Minimal IAM (optional)
#######################
# Allow a principal to connect & read/write DML on the DB
resource "google_spanner_database_iam_member" "db_user" {
  count    = var.iam_member != null ? 1 : 0
  instance = google_spanner_instance.this.name
  database = google_spanner_database.this.name
  role     = "roles/spanner.databaseUser"
  member   = var.iam_member # e.g. "user:you@example.com" or "serviceAccount:app-sa@PROJECT.iam.gserviceaccount.com"
}