variable project {
  type        = string
  description = "The Google Cloud Platform project name"
}

variable database_name {
  description = "Name of the database"
  type        = string
}

variable database_user {
  description = "Name of the database"
  type        = string
}

variable region {
  type = string
}

variable instance_name {
  description = "Name of the postgres instance (PROJECT_ID:REGION:INSTANCE_NAME))"
  type        = string
}
