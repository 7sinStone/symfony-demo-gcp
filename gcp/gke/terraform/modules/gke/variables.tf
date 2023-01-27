variable "project_id" {
  description = "The current project id"
}
variable "cluster_name" {
  description = "The cluster name"
}
variable "zone" {
  description = "the zone of the nodes of the cluster"
}
variable "region" {
  description = "the region of the project"
}
variable "machine_type" {
  default     = "e2-medium"
  description = "The machine type to use for the cluster"
}
variable "node_count" {
  default     = 1
  type        = number
  description = "the size of the default pool to use"
}

variable "cluster_version" {
  default     = "1.24"
  description = "The version of kubernetes"
}

variable "network_id" {
  description = "The network id to use of the created cluster"
}

variable "subnetwork_id" {
  description = "The subnetwork id to use of the created cluster"
}
