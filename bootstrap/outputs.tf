output "state_bucket" {
  description = "Set this as the TF_STATE_BUCKET GitHub repository variable."
  value       = aws_s3_bucket.terraform_state.id
}

output "lock_table" {
  description = "Set this as the TF_LOCK_TABLE GitHub repository variable."
  value       = aws_dynamodb_table.terraform_locks.name
}

output "plan_role_arn" {
  description = "Set this as the TF_PLAN_ROLE_ARN GitHub repository variable."
  value       = aws_iam_role.terraform_plan.arn
}

output "apply_role_arn" {
  description = "Set this as the TF_APPLY_ROLE_ARN GitHub repository variable."
  value       = aws_iam_role.terraform_apply.arn
}
