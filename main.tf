
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "bastion_host" {
  source = "terraform-google-modules/bastion-host/google//modules/bastion-group"
  
  project = var.project
  region  = var.region
  zone    = var.zone
  
  network = google_compute_network.vpc_network.self_link
  subnet = google_compute_subnetwork.subnet.self_link
  
}
  
resource "google_compute_network" "vpc_network" {
  name = "terraform-vpcnetwork"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name = "terraform-subnet"
  ip_cidr_range = "10.127.0.0/20"
  network = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}


resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_storage_bucket" "tfbucket_example989" {
  name          = "tfbucket_example989"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}
