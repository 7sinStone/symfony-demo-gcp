resource "random_password" "database_user_password" {
  length  = 30
  special = false
}

resource "google_sql_database_instance" "sql" {
  name             = var.instance_name
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project

  settings {
    tier      = "db-f1-micro"
    disk_type = "PD_HDD"
    database_flags {
      name  = "max_connections"
      value = "100"
    }
  }
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql.name
}

resource "google_sql_user" "user" {
  name     = var.database_user
  instance = google_sql_database_instance.sql.name
  password = random_password.database_user_password.result
}
