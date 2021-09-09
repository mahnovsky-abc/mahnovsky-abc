output "endpoint" {
  value       = module.terraform-aws-aurora.endpoint
  description = "The DNS address or endpoint of the RDS instance"
}

output "db_name" {
  value       = module.terraform-aws-aurora.db_name
  description = "Database name"
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

output "Databases" {
  value       = module.terraform-aws-aurora-manage.db_name
  description = "Databases"

}





