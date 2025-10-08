resource "google_bigtable_instance" "main" {
  name         = "ace-bt-instance"
  instance_type = "PRODUCTION"            # or "DEVELOPMENT" for non-prod
  display_name = "ACE Bigtable"

  cluster {
    cluster_id   = "ace-bt-cluster-1"
    zone         = var.zone               # e.g. us-central1-a
    num_nodes    = 3                      # start with 3 nodes
    storage_type = "SSD"
  }

  deletion_protection = false
}

# A sample table
resource "google_bigtable_table" "events" {
  name          = "events"
  instance_name = google_bigtable_instance.main.name

  column_family {
    family = "cf1"
  }
}