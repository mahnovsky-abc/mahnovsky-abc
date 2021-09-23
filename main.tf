# Configure the MySQL provider
provider "mysql" {
  endpoint = var.mysql-credentials.endpoint
  username = var.mysql-credentials.username
  password = var.mysql-credentials.password
}


# Create Databases
resource "mysql_database" "db" {
  for_each              = toset(var.new-databases)
  name                  = each.key
  default_character_set = var.default_character_set != "" ? var.default_character_set :  local.db_defaults.default_character_set #TODO use default in locals if each.key not set
  default_collation     = var.default_collation != "" ? var.default_collation : local.db_defaults.default_collation

}

data "aws_secretsmanager_secret" "database_credentials" {
  count = var.use-aws-secret-userlist ? 1 : 0 #TODO use secret manager or plaintext
  name  = var.aws-secret-manager-secrets-name
}

// Secret should be in AWS secret manager
data "aws_secretsmanager_secret_version" "database_credentials" {
  count      = var.use-aws-secret-userlist ? 1 : 0
  secret_id  = data.aws_secretsmanager_secret.database_credentials[0].id
  depends_on = [data.aws_secretsmanager_secret.database_credentials]
}


# create users from variable
resource "mysql_user" "users_create" {
  for_each = { for u in local.user-list : u.username => u
  }
  user               = each.value.username
  host               = lookup(var.user_hosts, each.value.host, local.user_defaults.host)
  plaintext_password = each.value.password
  tls_option  =  var.tls != "" ? var.tls : local.user_defaults.tls_option
  depends_on         = [mysql_database.db]

}

resource "mysql_user" "users_create_plugin_auth" {
  for_each = { for u in var.users-with-auth-plugin : u.username => u
  }
  user        = each.value.username
  host        = lookup(var.user_hosts, each.value.host, local.user_defaults.host)
  auth_plugin = each.value.auth_plugin
  tls_option  =  var.tls != "" ? var.tls : local.user_defaults.tls_option
  depends_on  = [mysql_database.db]
}

# Grant privileges
resource "mysql_grant" "users_create_privileges" {
  for_each = { for u in concat(local.user-list, var.users-with-auth-plugin) : u.username => u }
  user     = each.value.username
  host     = lookup(var.user_hosts, each.value.host, local.user_defaults.host)
  database = join(",", each.value.database)

  privileges = lookup(var.roles_priv, each.value.role, local.user_defaults.privileges)
  depends_on = [mysql_user.users_create, mysql_user.users_create_plugin_auth]

}

