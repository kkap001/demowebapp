output "public_subnets" {
  description = "List of public subnets"
  value       = aws_subnet.public[*].id
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}