variable "domain_name" {
  type        = string
  description = "Name of the OpenSearch domain."
}

variable "admin_email" {
  type        = string
  description = "Email for the admin user for the OpenSearch domain."
}

variable "opensearch_version" {
  type        = string
  description = "Version of OpenSearch to use."
  default     = "OpenSearch_1.2"
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs."
  default     = 30
}

variable "instance_type" {
  type        = string
  description = "Type of instance to use for OpenSearch cluster."
  default     = "t3.small.elasticsearch"
}

variable "enable_ebs" {
  type        = bool
  description = "Enable Elastic Block Store in OpenSearch domain."
  default     = true
}

variable "ebs_volume_size" {
  type        = number
  description = "Volume size of Elastic Block Store."
  default     = 10
}

variable "ebs_volume_type" {
  type        = string
  description = "Type of volume for Elastic Block Store."
  default     = "gp2"
}

variable "within_govcloud" {
  type        = bool
  description = "Is Cognito and OpenSearch being set up in AWS GovCloud?"
  default     = false
}