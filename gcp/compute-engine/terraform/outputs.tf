output "ip" {
  value = google_compute_instance.main.network_interface.0.access_config.0.nat_ip
}

output "database_url_connexion" {
  value     = module.database.database_url
  sensitive = true
}
