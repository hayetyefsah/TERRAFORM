terraform {
  required_providers {
    google = {
      source = "hashicorp/google"

    }
  }
}
provider "google" {
  version = "4.51.0"
  project = "yefsah-hayet"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}


# terraform {
#   backend "gcs" {
#     bucket      = "bucket_hayet"
#     prefix      = "terraform"
#     credentials = "yefsah-hayet-3196a937a336.json"
#   }
# }

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }
