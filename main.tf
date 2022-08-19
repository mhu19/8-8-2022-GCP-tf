
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}



resource "google_compute_instance" "vm_instance" {
  name         = "terraform-vm-instance"
  machine_type = var.machinetype

  boot_disk {
    initialize_params {
      image = var.machineimage
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
