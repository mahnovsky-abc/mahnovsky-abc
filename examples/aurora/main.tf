provider "aws" {
  region = local.region
}

locals {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "terraform-aws-aurora" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  source = "../../modules/aurora/"

  application                     = var.application
  environment                     = var.environment
  description                     = var.description
  Creator                         = var.Creator
  Repository                      = var.Repository
  tags                            = var.tags
  sport_prefix                    = var.sport_prefix
  admin_user                      = var.admin_user
  admin_password                  = var.admin_password
  vpc_id                          = var.vpc_id
  vpc_rds_security_group_ids      = var.vpc_rds_security_group_ids
  aws_region                      = local.region
  db_port                         = var.db_port
  standard_cluster                = var.standard_cluster
  instance_type                   = var.instance_type
  publicly_accessible             = var.publicly_accessible
  engine                          = var.engine
  engine_mode                     = var.engine_mode
  engine_version                  = var.engine_version
  rds_monitoring_interval         = var.rds_monitoring_interval
  rds_monitoring_role_arn         = var.rds_monitoring_role_arn
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  cluster_scaling_mode            = var.cluster_scaling_mode
  autoscale_min_capacity          = var.autoscale_min_capacity
  cluster_size                    = var.cluster_size
  cluster_family                  = var.cluster_family
  cluster_parameters              = var.cluster_parameters
  instance_parameters             = var.instance_parameters
  db_name                         = var.db_name
  retention_period                = var.retention_period
  backup_window                   = var.backup_window
  skip_final_snapshot             = var.skip_final_snapshot
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  kms_key_arn                     = var.kms_key_arn
  snapshot_identifier             = var.snapshot_identifier
  maintenance_window              = var.maintenance_window
  iam_authentication_enabled      = var.iam_authentication_enabled
  iam_roles                       = var.iam_roles
  backtrack_window                = var.backtrack_window
  scaling_configuration           = var.scaling_configuration
  replication_source_identifier   = var.replication_source_identifier
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  deletion_protection             = var.deletion_protection

  publicly_network_ids   = var.public_subnets
  private_network_ids    = var.private_subnets
  cidr_blocks_for_public = var.cidr_blocks_for_public
}