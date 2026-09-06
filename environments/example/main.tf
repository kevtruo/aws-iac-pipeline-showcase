provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-iac-pipeline-showcase"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}

variable "aws_region" {
  description = "AWS region for example resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Logical environment name."
  type        = string
  default     = "example"
}

variable "bucket_name" {
  description = "Globally unique example bucket name beginning with example-."
  type        = string

  validation {
    condition     = startswith(var.bucket_name, "example-")
    error_message = "bucket_name must begin with example- to match the scoped IAM policy."
  }
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_arn" {
  value = aws_s3_bucket.example.arn
}
