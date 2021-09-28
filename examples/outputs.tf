output "endpoint" {
  value       = var.mysql-credentials.endpoint
  description = "The DNS address or endpoint of the RDS instance"
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

output "Databases" {
  value       = module.terraform-aws-aurora-manage.db_name
  description = "Databases"
}

output "users" {
  value       = module.terraform-aws-aurora-manage.users
  sensitive   = true
  description = "List of users"
}





