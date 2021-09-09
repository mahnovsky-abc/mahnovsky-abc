output "endpoint" {
  value       = var.mysql-credentials.endpoint
  description = "The DNS address or endpoint of the RDS instance"
}


output "db_name" {
  value       = module.terraform-aws-aurora-manage.db_name
  description = "Database name"
}

output "admin_user" {
  value       = var.mysql-credentials.username
  description = "Database admin username"
  sensitive   = true
}

output "admin_password" {
  value       = var.mysql-credentials.password
  description = "Database admin password"
  sensitive   = true
}


