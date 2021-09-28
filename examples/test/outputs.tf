output "database_name" {
  value       = module.terraform-aws-aurora.database_name
  description = "Database name"
}

output "cluster_identifier" {
  value       = module.terraform-aws-aurora.cluster_identifier
  description = "Cluster Identifier"
}

output "arn" {
  value       = module.terraform-aws-aurora.arn
  description = "RDS Cluster ARN"
}

output "endpoint" {
  value       = module.terraform-aws-aurora.endpoint
  description = "The DNS address or endpoint of the RDS instance"
}

output "reader_endpoint" {
  value       = module.terraform-aws-aurora.reader_endpoint
  description = "A read-only endpoint for the Aurora cluster"
}

output "admin_user" {
  value       = module.terraform-aws-aurora.admin_user
  description = "Database admin username"
  sensitive   = true
}

output "admin_password" {
  value       = module.terraform-aws-aurora.admin_password
  description = "Database admin password"
  sensitive   = true
}
