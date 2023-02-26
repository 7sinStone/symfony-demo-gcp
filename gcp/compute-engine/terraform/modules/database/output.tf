output "database_url" {
  description = "The ODBC connetion string"
  value       = "postgresql://${google_sql_user.user.name}:${google_sql_user.user.password}@${google_sql_database_instance.sql.first_ip_address}/${var.database_name}?unix_socket=/cloudsql/${var.project}:${var.region}:${google_sql_database_instance.sql.name}"
}

output "database_instance" {
  description = "The database project-region-instance triple"
  value       = "${var.project}:${var.region}:${google_sql_database_instance.sql.name}"
}

output "short_instance_name" {
  description = "The short-form instance-only name"
  value       = google_sql_database_instance.sql.name
}
