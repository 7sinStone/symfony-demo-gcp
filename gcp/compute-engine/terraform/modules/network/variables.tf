variable "network_name" {
  description = "the new created network name"
}

variable "cidr_range" {
  default     = "10.0.0.0/24"
  description = "The cidr range to define for the main subnetwork to create"
}

variable "region" {
  description = "The region of the main subnetwork to create"
}
