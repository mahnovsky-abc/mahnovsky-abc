locals {
  local-user-list = var.use-local-userlist ? var.users : []
  aws-user-list   = var.use-aws-secret-userlist ? nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.database_credentials[0].secret_string)) : []
  user-list       = concat(local.local-user-list, local.aws-user-list)

  default_character_set = var.default_character_set != "" ? var.default_character_set : "utf8"
  default_collation     = var.default_collation != "" ? var.default_collation : "utf8_general_ci"

}