variable "rds_username" {
  type        = string
  description = "The username for the RDS instance"
}

variable "rds_password" {
  type        = string
  description = "The password for the RDS instance"
}

variable "rds_db_name" {
  type        = string
  description = "The name of the database to create"
}
