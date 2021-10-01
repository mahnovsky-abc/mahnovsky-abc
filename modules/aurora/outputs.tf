output "database_name" {
  value       = aws_rds_cluster.default.database_name
  description = "Database name"
}

output "cluster_identifier" {
  value       = aws_rds_cluster.default.cluster_identifier
  description = "Cluster Identifier"
}

output "arn" {
  value       = aws_rds_cluster.default.arn
  description = "RDS Cluster ARN"
}

output "endpoint" {
  value       = aws_rds_cluster.default.endpoint
  description = "The DNS address or endpoint of the RDS instance"
}

output "reader_endpoint" {
  value       = aws_rds_cluster.default.reader_endpoint
  description = "A read-only endpoint for the Aurora cluster"
}

output "default_instance_endpoint" {
  value       = aws_rds_cluster_instance.default[0].endpoint
  description = "Endpoint of default instance"
}

output "db_name" {
  value       = aws_rds_cluster.default.database_name
  description = "Database name"
}

output "admin_user" {
  value       = aws_rds_cluster.default.master_username
  description = "Database admin username"
  sensitive   = true
}

output "admin_password" {
  value       = aws_rds_cluster.default.master_password
  description = "Database admin password"
  sensitive   = true
}

output "engine" {
  value       = aws_rds_cluster.default.engine
  description = "Database name"
}

output "engine_mode" {
  value       = aws_rds_cluster.default.engine_mode
  description = "Database engine mode"
}

output "engine_version" {
  value       = aws_rds_cluster.default.engine_version
  description = "Database engine version"
}

output "port" {
  value       = aws_rds_cluster.default.port
  description = "Database engine version"
}
