variable "project_id" {
  default     = "symfony-demo-375421"
  description = "The project id"
}

variable "region" {
  default     = "europe-west1"
  description = "The region used to host the project resources"
}

variable "zone" {
  default     = "europe-west1-c"
  description = "The zone used to host the kubernetes cluster"
}

variable "project_name" {
  default     = "symfony-demo"
  description = "The project name. It is used as prefix for the names of the newly created resources"
}
