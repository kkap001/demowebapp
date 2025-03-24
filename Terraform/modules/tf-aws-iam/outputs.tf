output "iam_role_arn" {
  description = "ARN of the created IAM role"
  value       = aws_iam_role.admin_role.arn
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.admin_profile.name
}