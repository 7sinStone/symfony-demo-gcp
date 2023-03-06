output "network_id" {
  value = google_compute_network.main.id
}

output "subnetwork_self_link" {
  value = google_compute_subnetwork.main.self_link
}

output "global_address_name" {
  value = google_compute_global_address.main.name
}
