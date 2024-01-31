terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  project = "data-eng-zoomcamp-2024-412913"
  region  = "us-central1"

}

resource "google_storage_bucket" "demo-bucket" {
  name          = "data-eng-zoomcamp-2024-412913-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}
