terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0"
    }
  }
  backend "gcs" {
    # we use the GOOGLE_CREDENTIALS env variable to authenticate 
  }
}

# this variable is declared as TF_VAR_GOOGLE_CREDENTIALS env variable
variable "GOOGLE_CREDENTIALS" {
}


provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.GOOGLE_CREDENTIALS
}

# external disk to attach to the nodes 
resource "google_compute_disk" "main" {
  name = "${var.project_name}-external-disk"
  type = "pd-ssd"
  zone = var.zone
  size = 10
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      labels,
    ]
  }
}

module "network" {
  source       = "./modules/network"
  region       = var.region
  network_name = var.project_name
}

module "cluster" {
  source        = "./modules/gke"
  project_id    = var.project_id
  zone          = var.zone
  cluster_name  = "${var.project_name}-cluster"
  node_count    = 1
  region        = var.region
  network_id    = module.network.network_id
  subnetwork_id = module.network.subnetwork_id
}

