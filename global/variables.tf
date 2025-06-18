# variables.tf
variable "project" {
  description = "Name of the project (will be used in resource names)"
  type        = string
  default     = "training-project-bdm"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}