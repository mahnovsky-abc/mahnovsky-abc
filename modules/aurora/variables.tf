variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "Specify AWS region for deployment"
}

/*
GENERAL NETWORK PARAMETERS for the network mainly, please don't forget to add
VPN security group accordingly for the developers
*/
variable "sport_prefix" {
  type        = string
  description = "Provide valid sport prefix, ie.: AF, FB, BB, VLB, BSB, RPE"
}



variable "environment" {
  type        = string
  description = "Provide valid environment abbreviation, ie.: TST, CI, UAT, PROD, GEN"
  default     = "tst"
  validation {
    condition = (
      var.environment == "dev" ||
      var.environment == "qa" ||
      var.environment == "regression" ||
      var.environment == "migration" ||
      var.environment == "loadtest" ||
      var.environment == "staging" ||
      var.environment == "beta" ||
      var.environment == "prod" ||
      var.environment == "tst"
    )

    error_message = "The environment name must be: dev, qa, regression, migration, loadtest, staging, beta, prod, tst."
  }
}


variable "description" {
  description = "Provide short service or application description."
  type        = string
}

variable "Creator" {
  description = "Provide creator name to identify resource owner."
  type        = string
}

variable "Repository" {
  description = "Provide deployment repository."
  type        = string
  default     = "https://github.com/abcfinancial2/abc-tfmod-mysql"
}

variable "Artifacts" {
  description = "Describe required artifacts."
  type        = string
  default     = "artifact"
}

variable "tags" {
  description = "Provide additional tags if if needed."
  type        = map(string)
  default     = {}
}

variable "application" {
  type        = string
  description = "Provide application description, ie.: Stats-Engine"
}

variable "vpc_id" {
  type        = string
  description = "Provide VPC ID for RDS database"
}

variable "db_port" {
  type        = number
  default     = 3306
  description = "Database port"
}

/*
AWS RDS CLUSTER INSTANCE PARAMETERS
*/

variable "standard_cluster" {
  type        = bool
  default     = true
  description = "Non Serverless RDS Cluster"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "Cluster name. Live blank for autogenerate"
}


variable "instance_type" {
  type        = string
  default     = "db.t2.medium"
  description = "RDS Instance type"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Enable public access"
}

variable "cidr_blocks_for_public" {
  description = "A list of subnets to allow FROM access to rds"
  type        = list(string)
  default     = []
}

variable "allow_access_from_github" {
  type        = bool
  default     = false
  description = "Add external IP github to SG for allow access"
}


variable "publicly_network_ids" {
  type        = list(string)
  default     = []
  description = "List of public networks to allow access"
}


variable "private_accessible" {
  type        = bool
  default     = false
  description = "Enable private access from subnet range"
}

variable "private_network_ids" {
  type        = list(string)
  default     = []
  description = "List of private networks to allow access"
}

variable "engine" {
  type        = string
  default     = "aurora-mysql"
  description = "The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
}

variable "engine_mode" {
  type        = string
  default     = "provisioned"
  description = "The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless`"
}

variable "engine_version" {
  type        = string
  default     = "5.7.mysql_aurora.2.07.2"
  description = "The version number of the database engine to use"
}

variable "rds_monitoring_interval" {
  type        = number
  description = "Interval in seconds to collect metrics (0, 1, 5, 10, 15, 30, 60)"
  default     = 0
}

variable "rds_monitoring_role_arn" {
  type        = string
  default     = ""
  description = "The ARN for the IAM role that can send monitoring metrics to CloudWatch Logs"
}

variable "performance_insights_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable Performance Insights"
}

variable "performance_insights_kms_key_id" {
  type        = string
  default     = ""
  description = "The ARN for the KMS key to encrypt Performance Insights data"
}

#AWS RDS CLUSTER PARAMETERS
variable "cluster_scaling_mode" {
  type        = bool
  default     = true
  description = "Enable Cluster autoscaling"
}

variable "autoscale_min_capacity" {
  type        = number
  default     = 1
  description = "Minimal Instance number"
}

variable "cluster_size" {
  type        = number
  default     = 2
  description = "Number of database instances in the cluster"
}

variable "cluster_family" {
  type        = string
  default     = "aurora-mysql5.7"
  description = "The family of the DB cluster parameter group"
}

variable "cluster_parameters" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "List of DB cluster parameters to apply"
}

variable "instance_parameters" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "List of DB instance parameters to apply"
}

variable "db_name" {
  type        = string
  default     = "main"
  description = "Database name to create as default"
}

variable "admin_user" {
  type        = string
  description = "Database admin username"
}

variable "admin_password" {
  type        = string
  description = "Database admin password"
}

variable "retention_period" {
  type        = number
  default     = 15
  description = "Number of days to retain backups for rds"
}

variable "backup_window" {
  type        = string
  default     = "03:00-05:00"
  description = "Daily backup window time"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
  default     = true
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the RDS cluster storage is encrypted"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN for the KMS encryption key"
  default     = ""
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this cluster from a snapshot"
}

variable "vpc_rds_security_group_ids" {
  type        = list(string)
  description = "Specify existing SGs for VPC"
}

variable "maintenance_window" {
  type        = string
  default     = "wed:02:00-wed:03:00"
  description = "Weekly maintenance window"
}

variable "iam_authentication_enabled" {
  type    = bool
  default = false
}

variable "iam_roles" {
  type        = list(string)
  description = "Iam roles for the Aurora cluster"
  default     = []
}

variable "backtrack_window" {
  type        = number
  description = "The target backtrack window, in seconds, must be between 0 and 259200 (72 hours)"
  default     = 172800
}

variable "scaling_configuration" {
  type = list(object({
    auto_pause               = bool
    max_capacity             = number
    min_capacity             = number
    seconds_until_auto_pause = number
    timeout_action           = string
  }))
  default     = []
  description = "List of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless`"
}

variable "replication_source_identifier" {
  type        = string
  description = "ARN of a source DB cluster or DB instance if this is Read Replica"
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery"
  default     = ["audit", "error", "general", "slowquery"]
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled"
  default     = false
}
