provider "aws" {
  region = var.aws_region
}

module "abc-tfmod-naming-convention" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  source      = "git::https://github.com/abcfinancial2/abc-tfmod-naming-convention.git"
  aws_region  = var.aws_region
  environment = var.environment
  description = var.description
  Creator     = var.Creator
  Repository  = var.Repository
  Artifacts   = var.Artifacts
  tags        = var.tags #place custom tags if needed
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"

  name = var.vpc_name
  cidr = "10.20.0.0/22"

  azs                                    = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets                        = ["10.20.0.0/24", "10.20.1.0/24"]
  public_subnets                         = ["10.20.2.0/24", "10.20.3.0/24"]
  enable_ipv6                            = false
  manage_default_route_table             = false
  default_route_table_tags               = { DefaultRouteTable = true }
  enable_dns_hostnames                   = true
  enable_dns_support                     = true
  create_database_subnet_group           = true
  create_database_internet_gateway_route = false
  enable_nat_gateway                     = false
  single_nat_gateway                     = false
  manage_default_security_group          = false
  default_security_group_egress          = []

  public_subnet_tags = module.abc-tfmod-naming-convention.resources.rds.tags
  tags               = module.abc-tfmod-naming-convention.resources.rds.tags
  vpc_tags = module.abc-tfmod-naming-convention.resources.rds.tags
}


module "terraform-aws-aurora" {
  # When using these modules in your own templates, you will need to use a Git URL with a ref attribute that pins you
  # to a specific version of the modules, such as the following example:
  source = "../../modules/aurora"

  
  application                     = var.application
  environment                     = var.environment
  description                     = var.description
  Creator                         = var.Creator
  Repository                      = var.Repository
  tags                            = module.abc-tfmod-naming-convention.resources.rds.tags
  sport_prefix                    = var.sport_prefix
  admin_user                      = var.admin_user
  admin_password                  = var.admin_password
  vpc_id                          = module.vpc.vpc_id
  vpc_rds_security_group_ids      = [module.vpc.default_security_group_id]
  aws_region                      = var.aws_region
  db_port                         = var.db_port
  standard_cluster                = var.standard_cluster
  instance_type                   = var.instance_type
  publicly_accessible             = true
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

  publicly_network_ids   = module.vpc.public_subnets
  private_network_ids    = module.vpc.private_subnets
  cidr_blocks_for_public = var.cidr_blocks_for_public  
  allow_access_from_github = true
  # github public ip https://api.github.com/meta 
}


//mysql
module "terraform-aws-aurora-manage" {
  #depends_on [module.terraform-aws-aurora]
  source = "../../"
  // create users from variable file
  use-local-userlist = var.use-local-userlist
  //create users from AWS Secret
  use-aws-secret-userlist         = var.use-aws-secret-userlist
  aws-secret-manager-secrets-name = var.aws-secret-manager-secrets-name
  users-with-auth-plugin          = var.users-with-auth-plugin
  

  mysql-credentials = {
    endpoint = module.terraform-aws-aurora.endpoint
    username = module.terraform-aws-aurora.admin_user
    password = module.terraform-aws-aurora.admin_password
  }


  new-databases = var.new-databases
  users         = var.users
  roles         = var.roles
  user_hosts    = var.user_hosts
  roles_priv    = var.roles_priv
}