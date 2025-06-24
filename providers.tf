variable "aws-region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

provider "aws" {
  region = var.aws-region
}