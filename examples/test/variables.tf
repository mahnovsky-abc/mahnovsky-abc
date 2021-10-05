variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "Specify AWS region for deployment"
}

variable "sport_prefix" {
  type        = string
  description = "Provide valid sport prefix, ie.: AF, FB, BB, VLB, BSB, RPE"
  default     = "BSB"
}

variable "environment" {
  type        = string
  description = "Provide valid environment abbreviation, ie.: tst, dev, qa, beta, staging"
  default     = "tst"
}

variable "tags" {
  description = "Provide additional tags if if needed."
  type        = map(string)
  default     = { "name" : "demo-rds" }
}

variable "description" {
  description = "Provide short service or application description."
  type        = string
  default     = "Aurora cluster with users and privileges in databases"
}

variable "Creator" {
  description = "Provide creator name to identify resource owner."
  type        = string
  default     = "Developer"
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

variable "application" {
  type        = string
  description = "Provide application description, ie.: Stats-Engine"
  default     = "test-app"
}


variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "demo-vpc"
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
  default     = "demo"
  description = "Cluster name. Live blank for autogenerate"
}

variable "instance_type" {
  type        = string
  default     = "db.t2.medium"
  description = "RDS Instance type"
}

variable "publicly_accessible" {
  type        = bool
  default     = true
  description = "Enable public access"
}


variable "cidr_blocks_for_public" {
  description = "A list of subnets to allow FROM access to rds"
  type        = list(string)
  default     = ["91.193.125.11/32", "91.193.126.216/32", "46.37.195.48/32", "0.0.0.0/0"]
}

variable "allow_access_from_github" {
  type        = bool
  default     = false
  description = "Add external IP github to SG for allow access"
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
  default     = "5.7.mysql_aurora.2.07.1"
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
  default     = false
  description = "Enable Cluster autoscaling"
}

variable "autoscale_min_capacity" {
  type        = number
  default     = 2
  description = "Minimal Instance number"
}

variable "cluster_size" {
  type        = number
  default     = 1
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
  default     = "root"
  description = "Database admin username"
}

variable "admin_password" {
  type        = string
  default     = "testrunner01"
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

variable "maintenance_window" {
  type        = string
  default     = "wed:02:00-wed:03:00"
  description = "Weekly maintenance window"
}

# iam_authentication_enabled require supported RDS Instance type. db.t2.small and db.t3.small not supported.
# More https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html
variable "iam_authentication_enabled" {
  type    = bool
  default = true
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
  default = [
    "audit",
    "error",
    "general",
  "slowquery"]
}

variable "deletion_protection" {
  type        = bool
  description = "If the DB instance should have deletion protection enabled"
  default     = false
}

# AWS Aurora database parameters
variable "new-databases" {
  description = "List of new databases to create. Leave blank if not required"
  type        = list(any)
  default     = ["demo1", "demo2"]
}

variable "default_character_set" {
  description = "The default_character_set of the database."
  type        = string
  default     = "utf8"
}

variable "default_collation" {
  description = "The default_collation of the database."
  type        = string
  default     = "utf8_general_ci"
}


variable "user_hosts" {
  description = "list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable"
  type        = map(any)
  default = {
    "localhost" = "localhost"
    "dev"       = "10.10.0.0/255.255.0.0"
    "vpn"       = "10.50.0.0/255.255.0.0"
    "any"       = "%"
    "%"         = "%"
  }
}

variable "roles" {
  description = "Roles list"
  type        = list(any)
  default     = ["dev", "qa"]
}

variable "roles_priv" {
  description = "Template for privileges. Mapping user and privileges provided in 'users' variable"
  type        = map(any)
  default = {
    "dev" = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "DROP", "RELOAD", "PROCESS", "REFERENCES", "INDEX", "ALTER", "SHOW DATABASES", "CREATE TEMPORARY TABLES",
    "LOCK TABLES", "EXECUTE", "REPLICATION SLAVE", "REPLICATION CLIENT", "CREATE VIEW", "SHOW VIEW", "CREATE ROUTINE", "ALTER ROUTINE", "EVENT", "TRIGGER", "LOAD FROM S3", "SELECT INTO S3"]
    "qa" = ["SELECT", "EXECUTE", "UPDATE", "DELETE", "CREATE"]
  }
}

variable "use-local-userlist" {
  description = "Create users from list in variable ?"
  type        = bool
  default     = true

}

# local user list. host and role should be created upper
variable "users" {
  description = "Provide users list"
  type = list(object({
    username = string
    host     = string
    role     = string
    password = string
    database = list(string)
  }))
  default = [
    {
      username = "user1"
      host     = "vpn"
      role     = "qa"
      password = "12345678"
      database = ["*"]
    },
    {
      username = "user2"
      host     = "%"
      role     = "qa"
      password = "12345678"
      database = ["*"]
    }
  ]
}


variable "use-users-with-auth-plugin" {
  description = "Create users with plugin authentication?"
  type        = bool
  default     = true
}

# user list with plugin auth. host and role should be created upper
variable "users-with-auth-plugin" {
  description = "Provide users list to create"
  type = list(object({
    username    = string
    host        = string
    role        = string
    auth_plugin = string
    database    = list(string)

  }))
  default = [
    {
      username    = "user5"
      host        = "%"
      role        = "qa"
      auth_plugin = "AWSAuthenticationPlugin"
      database    = ["*"]
    }
  ]
}

variable "use-aws-secret-userlist" {
  description = "Create users from AWS Secret manager ?"
  type        = bool
  default     = false
}

# Please make sure that user list in secret is in correct format: should be in json like local user list upper
variable "aws-secret-manager-secrets-name" {
  description = "Name of AWS Secret manager secret with user list in json"
  type        = string
  default     = "mysql-users"
}
