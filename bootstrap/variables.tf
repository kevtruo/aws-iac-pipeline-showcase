variable "aws_region" {
  description = "AWS region for the Terraform state resources."
  type        = string
  default     = "us-east-1"
}

variable "github_owner" {
  description = "GitHub user or organization that owns the repository."
  type        = string
}

variable "github_repository" {
  description = "Repository name only, without the owner."
  type        = string
}

variable "apply_environment" {
  description = "Protected GitHub Environment used by the apply job."
  type        = string
  default     = "production-apply"
}

variable "name_prefix" {
  description = "Globally distinguishable prefix for example resources."
  type        = string
  default     = "iac-showcase"
}
