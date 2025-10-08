# terraform

```sh
terraform init
terraform fmt       # Format code
terraform validate  # Check for errors
terraform plan      # Preview changes
terraform apply     # Deploy
terraform destroy   # Clean up
terraform output
```


```hcl
data "google_compute_image" "debian" {
  family  = "debian-11"
  project = "debian-cloud"
}

variable "regions" {
  type    = list(string)
  default = ["us-central1", "us-east1", "us-west1"]
}

output "first_region" {
  value = var.regions[0] # us-central1
}

variable "vm_types" {
  type = map(string)
  default = {
    dev  = "e2-micro"
    prod = "e2-medium"
  }
}

output "prod_vm_type" {
  value = var.vm_types["prod"] # e2-medium
}

variable "create_vm" {
  type    = bool
  default = true
}

resource "google_compute_instance" "vm" {
  count        = var.create_vm ? 1 : 0
  name         = "conditional-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

variable "bucket_names" {
  default = ["logs", "backups", "media"]
}

resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  name     = "demo-${each.value}"
  location = "US"
}
```