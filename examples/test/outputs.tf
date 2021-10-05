# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on Default VPC creation"
  value       = module.vpc.default_security_group_id
}


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

output "Databases" {
  value       = module.terraform-aws-aurora-manage.db_name
  description = "Databases"
}

output "users" {
  value       = module.terraform-aws-aurora-manage.users
  sensitive   = true
  description = "List of users"
}

output "privileges" {
  value       = module.terraform-aws-aurora-manage.privileges
  description = "List of privileges"
}



