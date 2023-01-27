resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name                     = "${var.network_name}-subnetwork"
  ip_cidr_range            = var.cidr_range
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true
}
