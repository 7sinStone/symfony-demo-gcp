output "disk_id" {
  value = google_compute_disk.main.id
}

output "cluster_name" {
  value = module.cluster.cluster_name
}
