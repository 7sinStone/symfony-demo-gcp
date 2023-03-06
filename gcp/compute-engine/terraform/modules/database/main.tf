resource "random_password" "database_user_password" {
  length  = 30
  special = false
}

// The private service access resource
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_id
  reserved_peering_ranges = [var.global_address_name]
  service = "servicenetworking.googleapis.com"
}


resource "google_sql_database_instance" "main" {
  name             = var.instance_name
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier      = "db-f1-micro"
    disk_type = "PD_HDD"
    database_flags {
      name  = "max_connections"
      value = "100"
    }

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.network_id
      enable_private_path_for_google_cloud_services = true
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "main" {
  name     = var.database_name
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "user" {
  name     = var.database_user
  instance = google_sql_database_instance.main.name
  password = random_password.database_user_password.result
}
