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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Example default, adjust as needed
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"] # Example default, ensure these fit within vpc_cidr
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"] # Example default, ensure these fit within vpc_cidr
}


variable "TestImageUri" {
  description = "Docker image URI for the ECS task"
  type        = string
  default     = "ubuntu:22.04"

}

variable "DefaultImageUri" {
  description = "Default Docker image URI for the ECS task"
  type        = string
  default     = "123456789012.dkr.ecr.us-west-2.amazonaws.com/my-repo:latest"

  validation {
    condition     = can(regex("^\\d{12}\\.dkr\\.ecr\\.[a-z0-9-]+\\.amazonaws\\.com\\/[a-z0-9-]+:[a-z0-9._-]+$", var.DefaultImageUri))
    error_message = "ImageUri must be a valid ECR image URI."
  }
}