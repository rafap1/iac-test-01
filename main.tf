resource "google_compute_instance" "web_vm" {
  project      = "finance-application-01-dev"
  name         = "${local.name_prefix}-vm"
  machine_type = var.machine_type
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = "default"
  }
}
