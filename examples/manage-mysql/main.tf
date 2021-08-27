provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "terraform-aws-aurora-manage" {
  source                          = "../../modules/manage-mysql/"
  // create users from variable file
  use-local-userlist = true
  //create users from AWS Secret
  use-aws-secret-userlist = true

  mysql-credentials = {
    endpoint = "test-aurora-mysql.cluster-cmz3l43pawky.eu-west-1.rds.amazonaws.com:3306"
    username = "root"
    password = "testrunner01"
}
}