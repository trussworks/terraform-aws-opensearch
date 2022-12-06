# ---------------------------------------------------------------------------------------------------------------------
# TERRAFORM VARIABLES EXAMPLE
# ---------------------------------------------------------------------------------------------------------------------
variable "domain_name" {
  type        = string
  description = "Name of the OpenSearch domain."
}

variable "admin_email" {
  type        = string
  description = "Email for the admin user for the OpenSearch domain."
}
