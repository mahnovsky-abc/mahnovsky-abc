

module "terraform-aws-naming" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  source      = "git@github.com:abcfinancial2/abc-tfmod-naming-convention.git"
  environment = var.environment
  description = var.description
  Creator     = var.Creator
  Repository  = var.Repository
  Artifacts   = var.Artifacts
  tags        = var.tags #place custom tags if needed
}

# github public ip https://api.github.com/meta
data "github_ip_ranges" "git" {

}

locals {
  min_instance_count     = var.cluster_scaling_mode ? var.autoscale_min_capacity : var.cluster_size
  cluster_instance_count = var.standard_cluster ? local.min_instance_count : 0
  cidr_public            = var.cidr_blocks_for_public
}

resource "aws_security_group" "default" {
  count       = var.standard_cluster ? 1 : 0
  name        = "sg"
  description = "Allow inbound traffic from Security Groups"
  vpc_id      = var.vpc_id


  dynamic "ingress" {
    for_each = var.publicly_accessible ? [0] : []
    content {
      from_port   = var.db_port
      to_port     = var.db_port
      protocol    = "tcp"
      cidr_blocks = local.cidr_public
    }
  }

  dynamic "ingress" {
    for_each = var.allow_access_from_github ? [0] : []
    content {
      from_port        = var.db_port
      to_port          = var.db_port
      protocol         = "tcp"
      cidr_blocks      = [for block in data.github_ip_ranges.git.git : block if length(regexall("::", block)) == 0]
      ipv6_cidr_blocks = [for block in data.github_ip_ranges.git.git : block if length(regexall("::", block)) > 0]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.terraform-aws-naming.resources.rds.tags
}



resource "aws_rds_cluster" "default" {
  cluster_identifier                  = lower(join("-", [var.environment, var.engine, "cluster", var.cluster_name]))
  database_name                       = var.db_name
  master_username                     = var.admin_user
  master_password                     = var.admin_password
  backup_retention_period             = var.retention_period
  preferred_backup_window             = var.backup_window
  final_snapshot_identifier           = join("-", [var.environment, var.engine, "final-snapshot"])
  skip_final_snapshot                 = var.skip_final_snapshot
  apply_immediately                   = var.apply_immediately
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.kms_key_arn
  snapshot_identifier                 = var.snapshot_identifier
  vpc_security_group_ids              = compact(flatten([join("", aws_security_group.default.*.id)]))
  preferred_maintenance_window        = var.maintenance_window
  db_subnet_group_name                = aws_db_subnet_group.default.name
  db_cluster_parameter_group_name     = join("", aws_rds_cluster_parameter_group.default.*.name)
  iam_database_authentication_enabled = var.iam_authentication_enabled
  engine                              = var.engine
  engine_version                      = var.engine_version
  engine_mode                         = var.engine_mode
  iam_roles                           = var.iam_roles
  backtrack_window                    = var.backtrack_window
  tags                                = module.terraform-aws-naming.resources.rds.tags
  copy_tags_to_snapshot               = true

  dynamic "scaling_configuration" {
    for_each = var.scaling_configuration
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }

  replication_source_identifier   = var.replication_source_identifier
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  deletion_protection             = var.deletion_protection
}

resource "aws_rds_cluster_instance" "default" {
  count                           = local.cluster_instance_count
  identifier                      = join("-", [lower(var.environment), var.engine, "${count.index + 1}"])
  cluster_identifier              = join("", aws_rds_cluster.default.*.id)
  instance_class                  = var.instance_type
  db_subnet_group_name            = aws_db_subnet_group.default.name
  db_parameter_group_name         = join("", aws_db_parameter_group.default.*.name)
  publicly_accessible             = var.publicly_accessible
  engine                          = var.engine
  engine_version                  = var.engine_version
  monitoring_interval             = var.rds_monitoring_interval
  monitoring_role_arn             = var.rds_monitoring_role_arn
  performance_insights_enabled    = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  tags                            = module.terraform-aws-naming.resources.rds.tags
}



resource "aws_db_subnet_group" "default" {
  name        = "db_subnet_group"
  subnet_ids  = var.publicly_network_ids
  description = "Allowed subnets for DB cluster instances"
  tags        = module.terraform-aws-naming.resources.rds.tags
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = join("-", [lower(var.environment), var.engine, "pg", "cluster"])
  description = "DB cluster parameter group"
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
  tags = module.terraform-aws-naming.resources.rds.tags
}


resource "aws_db_parameter_group" "default" {
  name        = join("-", [lower(var.environment), var.engine, "pg"])
  description = "RDS parameter group"
  family      = var.cluster_family

  dynamic "parameter" {
    for_each = var.instance_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }

  tags = module.terraform-aws-naming.resources.rds.tags
}
