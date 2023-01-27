# create the service account used by GKE 
resource "google_service_account" "main" {
  account_id   = "gkeserviceaccount"
  display_name = "gke service sccount"
}

# add the artifact registry reader role to the GKE service account
resource "google_project_iam_member" "artifact-registry-reader-role" {
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.main.email}"
  project = var.project_id
}

# create a new repo to contain the GKE images
resource "google_artifact_registry_repository" "main" {
  location      = var.region
  repository_id = "symfony-demo"
  description   = "The docker repository"
  format        = "DOCKER"
}

# create the main cluster
resource "google_container_cluster" "main" {
  name     = var.cluster_name
  location = var.zone

  network    = var.network_id
  subnetwork = var.subnetwork_id

  lifecycle {
    ignore_changes = [
      # Ignore changes to min-master-version as that gets changed
      # after deployment to minimum precise version Google has
      min_master_version,
    ]
  }

  remove_default_node_pool = true
  initial_node_count       = 1
  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }
}

# create the main nodes pool and link it to the cluster
resource "google_container_node_pool" "nodes" {
  name       = "${var.cluster_name}-nodes"
  location   = var.zone
  cluster    = google_container_cluster.main.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    spot         = true

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.main.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}


