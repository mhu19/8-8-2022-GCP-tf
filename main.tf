terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 2.5"
    }
  }
}

provider "google" {

  project = var.project
  region  = var.region
  zone    = var.zone

}

