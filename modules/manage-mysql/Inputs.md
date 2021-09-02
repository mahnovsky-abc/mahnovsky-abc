## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.55.0 |
| <a name="requirement_mysql"></a> [mysql](#requirement\_mysql) | 1.10.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.55.0 |
| <a name="provider_mysql"></a> [mysql](#provider\_mysql) | 1.10.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mysql_database.db](https://registry.terraform.io/providers/winebarrel/mysql/1.10.5/docs/resources/database) | resource |
| [mysql_grant.users_create-priv](https://registry.terraform.io/providers/winebarrel/mysql/1.10.5/docs/resources/grant) | resource |
| [mysql_user.users_create](https://registry.terraform.io/providers/winebarrel/mysql/1.10.5/docs/resources/user) | resource |
| [aws_secretsmanager_secret.database_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.database_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws-secret-manager-secrets-name"></a> [aws-secret-manager-secrets-name](#input\_aws-secret-manager-secrets-name) | Name of AWS Secret manager secret with user list in json | `string` | `"mysql-users"` | no |
| <a name="input_create-database"></a> [create-database](#input\_create-database) | Create new database ? | `bool` | `false` | no |
| <a name="input_mysql-credentials"></a> [mysql-credentials](#input\_mysql-credentials) | Credential for access to MySQL cluster | `map(any)` | <pre>{<br>  "endpoint": "localhost:3306",<br>  "password": "",<br>  "username": "root"<br>}</pre> | no |
| <a name="input_new-db-name"></a> [new-db-name](#input\_new-db-name) | New db name. Leave blank if not required | `string` | `""` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles list | `list(any)` | <pre>[<br>  "dev",<br>  "qa"<br>]</pre> | no |
| <a name="input_roles_priv"></a> [roles\_priv](#input\_roles\_priv) | Template for privileges. Mapping user and privileges provided in 'users' variable | `map(any)` | <pre>{<br>  "dev": [<br>    "SELECT",<br>    "INSERT",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE",<br>    "DROP",<br>    "RELOAD",<br>    "PROCESS",<br>    "REFERENCES",<br>    "INDEX",<br>    "ALTER",<br>    "SHOW DATABASES",<br>    "CREATE TEMPORARY TABLES",<br>    "LOCK TABLES",<br>    "EXECUTE",<br>    "REPLICATION SLAVE",<br>    "REPLICATION CLIENT",<br>    "CREATE VIEW",<br>    "SHOW VIEW",<br>    "CREATE ROUTINE",<br>    "ALTER ROUTINE",<br>    "EVENT",<br>    "TRIGGER",<br>    "LOAD FROM S3",<br>    "SELECT INTO S3"<br>  ],<br>  "qa": [<br>    "SELECT",<br>    "EXECUTE",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE"<br>  ]<br>}</pre> | no |
| <a name="input_use-aws-secret-userlist"></a> [use-aws-secret-userlist](#input\_use-aws-secret-userlist) | Create users from AWS Secret manager ? | `bool` | `false` | no |
| <a name="input_use-local-userlist"></a> [use-local-userlist](#input\_use-local-userlist) | Create users from list in variable ? | `bool` | `false` | no |
| <a name="input_user_hosts"></a> [user\_hosts](#input\_user\_hosts) | list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable | `map(any)` | <pre>{<br>  "%": "%",<br>  "any": "%",<br>  "dev": "10.10.0.0/255.255.0.0",<br>  "localhost": "localhost",<br>  "vpn": "10.50.0.0/255.255.0.0"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | Provide users list | <pre>list(object({<br>    username = string<br>    host     = string<br>    role     = string<br>    password = string<br>  }))</pre> | <pre>[<br>  {<br>    "host": "vpn",<br>    "password": "123456543",<br>    "role": "qa",<br>    "username": "jdoe6"<br>  },<br>  {<br>    "host": "%",<br>    "password": "9518462",<br>    "role": "qa",<br>    "username": "jdoe5"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
