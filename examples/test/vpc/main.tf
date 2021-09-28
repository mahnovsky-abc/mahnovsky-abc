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
  cidr = var.vpc_cidr

  azs                                    = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets                        = var.private_subnets
  public_subnets                         = var.public_subnets
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
