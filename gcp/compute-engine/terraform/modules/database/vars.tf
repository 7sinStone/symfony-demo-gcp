variable "project" {
  type        = string
  description = "The Google Cloud Platform project name"
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "database_user" {
  description = "Name of the database"
  type        = string
}

variable "region" {
  description = "The region used by the cloud sql instance"
  type        = string
}

variable "instance_name" {
  description = "Name of the postgres instance (PROJECT_ID:REGION:INSTANCE_NAME))"
  type        = string
}

variable "network_id" {
  description = "The network id used by the instance"
  type        = string
}

variable "global_address_name" {
  description = "The name of the global address resource used in the current project"
  type        = string
}
