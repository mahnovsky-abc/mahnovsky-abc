## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-aws-aurora-manage"></a> [terraform-aws-aurora-manage](#module\_terraform-aws-aurora-manage) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws-secret-manager-secrets-name"></a> [aws-secret-manager-secrets-name](#input\_aws-secret-manager-secrets-name) | Name of AWS Secret manager secret with user list in json | `string` | `"mysql-users"` | no |
| <a name="input_default_character_set"></a> [default\_character\_set](#input\_default\_character\_set) | The default\_character\_set of the database. | `string` | `"utf8"` | no |
| <a name="input_default_collation"></a> [default\_collation](#input\_default\_collation) | The default\_collation of the database. | `string` | `"utf8_general_ci"` | no |
| <a name="input_mysql-credentials"></a> [mysql-credentials](#input\_mysql-credentials) | Credential for access to MySQL cluster | `map(any)` | <pre>{<br>  "endpoint": "tst-aurora-mysql-cluster.cluster-cmz3l43pawky.eu-west-1.rds.amazonaws.com",<br>  "password": "testrunner01",<br>  "username": "root"<br>}</pre> | no |
| <a name="input_new-databases"></a> [new-databases](#input\_new-databases) | List of new databases to create. Leave blank if not required | `list(any)` | <pre>[<br>  "db1",<br>  "db2"<br>]</pre> | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles list | `list(any)` | <pre>[<br>  "dev",<br>  "qa"<br>]</pre> | no |
| <a name="input_roles_priv"></a> [roles\_priv](#input\_roles\_priv) | Template for privileges. Mapping user and privileges provided in 'users' variable | `map(any)` | <pre>{<br>  "dev": [<br>    "SELECT",<br>    "INSERT",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE",<br>    "DROP",<br>    "RELOAD",<br>    "PROCESS",<br>    "REFERENCES",<br>    "INDEX",<br>    "ALTER",<br>    "SHOW DATABASES",<br>    "CREATE TEMPORARY TABLES",<br>    "LOCK TABLES",<br>    "EXECUTE",<br>    "REPLICATION SLAVE",<br>    "REPLICATION CLIENT",<br>    "CREATE VIEW",<br>    "SHOW VIEW",<br>    "CREATE ROUTINE",<br>    "ALTER ROUTINE",<br>    "EVENT",<br>    "TRIGGER",<br>    "LOAD FROM S3",<br>    "SELECT INTO S3"<br>  ],<br>  "qa": [<br>    "SELECT",<br>    "EXECUTE",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE"<br>  ]<br>}</pre> | no |
| <a name="input_use-aws-secret-userlist"></a> [use-aws-secret-userlist](#input\_use-aws-secret-userlist) | Create users from AWS Secret manager ? | `bool` | `true` | no |
| <a name="input_use-local-userlist"></a> [use-local-userlist](#input\_use-local-userlist) | Create users from list in variable ? | `bool` | `false` | no |
| <a name="input_user_hosts"></a> [user\_hosts](#input\_user\_hosts) | list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable | `map(any)` | <pre>{<br>  "%": "%",<br>  "any": "%",<br>  "dev": "10.10.0.0/255.255.0.0",<br>  "localhost": "localhost",<br>  "vpn": "10.50.0.0/255.255.0.0"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | Provide users list | <pre>list(object({<br>    username = string<br>    host     = string<br>    role     = string<br>    password = string<br>    database = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "database": [<br>      "*"<br>    ],<br>    "host": "vpn",<br>    "password": "123456543",<br>    "role": "qa",<br>    "username": "user1"<br>  },<br>  {<br>    "database": [<br>      "*"<br>    ],<br>    "host": "%",<br>    "password": "9518462",<br>    "role": "qa",<br>    "username": "user2"<br>  }<br>]</pre> | no |
| <a name="input_users-with-auth-plugin"></a> [users-with-auth-plugin](#input\_users-with-auth-plugin) | Provide users list to create | <pre>list(object({<br>    username    = string<br>    host        = string<br>    role        = string<br>    auth_plugin = string<br>    database    = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "auth_plugin": "AWSAuthenticationPlugin",<br>    "database": [<br>      "*"<br>    ],<br>    "host": "%",<br>    "role": "qa",<br>    "username": "user3"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Databases"></a> [Databases](#output\_Databases) | Databases |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Database admin password |
| <a name="output_admin_user"></a> [admin\_user](#output\_admin\_user) | Database admin username |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The DNS address or endpoint of the RDS instance |
| <a name="output_users"></a> [users](#output\_users) | List of users |
