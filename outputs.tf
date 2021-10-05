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

#add priv to output?

output "privileges" {
  value       = mysql_grant.users_create_privileges
  description = "List of privileges"
}
