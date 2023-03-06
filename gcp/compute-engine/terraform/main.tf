terraform {
  required_version = ">= 1.0.11"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
  backend "gcs" {
  }
}

variable "GOOGLE_CREDENTIALS" {
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.GOOGLE_CREDENTIALS
}

provider "tls" {
  // no config needed
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "../google_compute_engine"
  file_permission = "0600"
}

data "google_client_openid_userinfo" "me" {}


// main compute engine instance
resource "google_compute_instance" "main" {
  project      = var.project_id
  name         = "symfony-demo-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = module.network.subnetwork_self_link
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  tags = ["http-server", "https-server"]
}

// create the cloud sql instance
module "database" {
  source              = "./modules/database"
  project             = var.project_id
  region              = var.region
  database_name       = "symfony-demo"
  database_user       = "symfony_demo_db_user"
  instance_name       = "symfony-demo"
  network_id          = module.network.network_id
  global_address_name = module.network.global_address_name
}

// create the custom vpc
module "network" {
  source       = "./modules/network"
  region       = var.region
  network_name = "symfony-demo"
}