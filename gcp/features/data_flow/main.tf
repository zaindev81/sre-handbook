# Temp/staging bucket for the job
resource "google_storage_bucket" "dataflow_bucket" {
  name          = "${var.project_id}-dataflow-bucket"
  location      = var.region
  force_destroy = true
}

# echo "hello world" > data.txt
# export BUCKET_NAME=${var.project_id}-dataflow-bucket
# gsutil cp data.txt gs://$BUCKET_NAME/input/data.txt
# gsutil ls gs://$BUCKET_NAME/output/
# gsutil cat gs://$BUCKET_NAME/output/results*

# gcloud dataflow jobs list --region asia-southeast1 --project <>

# terraform taint google_dataflow_job.dataflow_job
# terraform apply

resource "random_id" "suffix" { byte_length = 3 }

# Launch a Dataflow job from a public template (Word Count)
resource "google_dataflow_job" "dataflow_job" {
  name               = "sample-dataflow-job-${random_id.suffix.hex}"
  # Use region-specific public template bucket:
  #   gs://dataflow-templates-<region>/latest/Word_Count
  template_gcs_path = "gs://dataflow-templates-${var.region}/latest/Word_Count"
  temp_gcs_location = "gs://${google_storage_bucket.dataflow_bucket.name}/temp"
  region            = var.region

  parameters = {
    inputFile  = "gs://${google_storage_bucket.dataflow_bucket.name}/input/data.txt"
    output     = "gs://${google_storage_bucket.dataflow_bucket.name}/output/results"
  }
}
