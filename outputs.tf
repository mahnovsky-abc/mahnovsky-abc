#TODO verify outputs and add missing ones

output "endpoint" {
  value       = var.mysql-credentials.endpoint
  description = "The DNS address or endpoint of the RDS instance"
}


output "db_name" {
  value = toset([
    for db in mysql_database.db : db.name
  ])
  description = "Database name"
}

output "users" {
  value       = mysql_user.users_create
  sensitive   = true
  description = "List of users "
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


