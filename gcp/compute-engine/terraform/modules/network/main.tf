// The custom vpc resource
resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

locals {
  firewall_rules = [
    {
      name      = "${var.network_name}-ssh-firewall"
      protocols = ["tcp"]
      priority  = "65534"
      ports     = ["22"]
      source    = ["0.0.0.0/0"]
    },
    {
      name      = "${var.network_name}-allow-internal-firewall"
      protocols = ["tcp", "udp", "icmp"]
      priority  = "65534"
      source    = [var.cidr_range]
      ports     = ["0-65535"]
    },
    {
      name        = "${var.network_name}-http-firewall"
      protocols   = ["tcp"]
      priority    = "65534"
      source      = [var.cidr_range]
      ports       = ["80"]
      target_tags = ["http-server"]
    }
  ]
}

resource "google_compute_firewall" "default" {
  for_each = { for index, rule in local.firewall_rules : index => rule }
  name     = each.value.name
  network  = google_compute_network.main.name

  dynamic "allow" {
    for_each = each.value.protocols
    content {
      protocol = allow.value
      ports    = allow.value != "icmp" ? each.value.ports : []
    }
  }

  source_ranges = each.value.source
}


// the custom subnetwork
resource "google_compute_subnetwork" "main" {
  name          = "${var.network_name}-subnetwork"
  ip_cidr_range = var.cidr_range
  region        = var.region
  network       = google_compute_network.main.name
}

// The global address resource
resource "google_compute_global_address" "main" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main.id
}
