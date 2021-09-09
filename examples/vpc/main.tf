provider "aws" {
  region = local.region
}

locals {
  region = var.aws_region
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  //source = "../../vpc/"
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.7.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs                                    = ["${local.region}a", "${local.region}b"]
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

  public_subnet_tags = var.tags
  tags               = var.tags
  vpc_tags           = var.tags



}
