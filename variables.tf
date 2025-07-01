# variables.tf
variable "project" {
  description = "Name of the project (will be used in resource names)"
  type        = string
  default     = "training-project-bdm"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "TestImageUri" {
  description = "Docker image URI for the ECS task"
  type        = string
  default     = "ubuntu:22.04"
  
}

variable "DefaultImageUri" {
  description = "Default Docker image URI for the ECS task"
  type        = string
  default     = "public.ecr.aws/amazonlinux/amazonlinux:latest"

  validation {
    condition     = can(regex("^\\d{12}\\.dkr\\.ecr\\.[a-z0-9-]+\\.amazonaws\\.com\\/[a-z0-9-]+:[a-z0-9._-]+$", var.ImageUri))
    error_message = "ImageUri must be a valid ECR image URI."
  }
}