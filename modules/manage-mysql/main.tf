# Configure the MySQL provider
provider "mysql" {
  endpoint = var.mysql-credentials.endpoint
  username = var.mysql-credentials.username
  password = var.mysql-credentials.password
}


# Create a Database
resource "mysql_database" "db" {
  count = var.create-database ? 1 : 0
  name  = var.new-db-name
}


data "aws_secretsmanager_secret" "database_credentials" {
  //count = var.use-aws-secret-userlist ? 1 : 0
  name = var.aws-secret-manager-secrets-name
}

// Secret should be in AWS secret manager
data "aws_secretsmanager_secret_version" "database_credentials" {
  //count = var.use-aws-secret-userlist ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.database_credentials.id


}

# create users from variable
resource "mysql_user" "users_create" {
  for_each = { for u in local.user-list : u.username => u
  }
  user               = each.value.username
  host               = lookup(var.user_hosts, each.value.host, "localhost")
  plaintext_password = each.value.password

}


# Grant priv
resource "mysql_grant" "users_create-priv" {

  for_each = { for u in local.user-list : u.username => u }
  user     = each.value.username
  host     = lookup(var.user_hosts, each.value.host, "localhost")
  database = "*"

  # Default: USAGE = “no privileges.”
  privileges = lookup(var.roles_priv, each.value.role, ["USAGE"])

  depends_on = [mysql_user.users_create]
}

