output "name" {
  description = "The name of the created IAM role"
  value       = aws_iam_role.this.name
}

output "unique_id" {
  description = "The stable and unique string identifying the role"
  value       = aws_iam_role.this.unique_id
}

output "arn" {
  description = "The ARN of the role"
  value       = aws_iam_role.this.arn
}

output "policy" {
  description = "Role policy document in JSON format"
  value       = data.aws_iam_policy_document.permissions_aggregated.json
}
