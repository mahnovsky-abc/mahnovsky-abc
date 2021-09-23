provider "aws" {
  region = "eu-west-1"
}

module "terraform-aws-aurora-manage" {
  source = "../../"
  // create users from variable file
  use-local-userlist = var.use-local-userlist
  //create users from AWS Secret
  use-aws-secret-userlist         = var.use-aws-secret-userlist
  aws-secret-manager-secrets-name = var.aws-secret-manager-secrets-name
  users-with-auth-plugin          = var.users-with-auth-plugin
  

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