// list of users to be created or updated
locals {
local-user-list =  var.use-local-userlist ? var.users  : []
aws-user-list =  var.use-aws-secret-userlist ? jsondecode(data.aws_secretsmanager_secret_version.database_credentials.secret_string)  : []

user-list = distinct(concat(local.local-user-list, local.aws-user-list))

}