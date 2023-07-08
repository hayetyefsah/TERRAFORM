terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "yefsah-hayet"
  region  = "eu-west1"
  zone    = "eu-west1-b"
}


terraform {
  backend "gcs" {
    bucket      = "bucket_hayet"
    prefix      = "terraform"
    credentials = "yefsah-hayet-3196a937a336.json"
  }
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }
