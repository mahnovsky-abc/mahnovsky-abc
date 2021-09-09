provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


module "terraform-aws-aurora-manage" {
  source = "../../"
  // create users from variable file
  use-local-userlist = var.use-local-userlist
  //create users from AWS Secret
  use-aws-secret-userlist         = var.use-aws-secret-userlist
  aws-secret-manager-secrets-name = var.aws-secret-manager-secrets-name



  mysql-credentials = {
    endpoint = var.mysql-credentials.endpoint
    username = var.mysql-credentials.username
    password = var.mysql-credentials.password
  }

  // create-database = var.create-database
  new-databases = var.new-databases
  users         = var.users
  roles         = var.roles
  user_hosts    = var.user_hosts
  roles_priv    = var.roles_priv


}