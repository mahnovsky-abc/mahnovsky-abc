## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.55.0 |
| <a name="requirement_mysql"></a> [mysql](#requirement\_mysql) | 1.10.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 2.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_abc-tfmod-naming-convention"></a> [abc-tfmod-naming-convention](#module\_abc-tfmod-naming-convention) | git::https://github.com/abcfinancial2/abc-tfmod-naming-convention.git | n/a |
| <a name="module_terraform-aws-aurora"></a> [terraform-aws-aurora](#module\_terraform-aws-aurora) | ../../modules/aurora | n/a |
| <a name="module_terraform-aws-aurora-manage"></a> [terraform-aws-aurora-manage](#module\_terraform-aws-aurora-manage) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.7.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Artifacts"></a> [Artifacts](#input\_Artifacts) | Describe required artifacts. | `string` | `"artifact"` | no |
| <a name="input_Creator"></a> [Creator](#input\_Creator) | Provide creator name to identify resource owner. | `string` | `"Developer"` | no |
| <a name="input_Repository"></a> [Repository](#input\_Repository) | Provide deployment repository. | `string` | `"https://github.com/abcfinancial2/abc-tfmod-mysql"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Database admin password | `string` | `"testrunner01"` | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Database admin username | `string` | `"root"` | no |
| <a name="input_application"></a> [application](#input\_application) | Provide application description, ie.: Stats-Engine | `string` | `"test-app"` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| <a name="input_autoscale_min_capacity"></a> [autoscale\_min\_capacity](#input\_autoscale\_min\_capacity) | Minimal Instance number | `number` | `2` | no |
| <a name="input_aws-secret-manager-secrets-name"></a> [aws-secret-manager-secrets-name](#input\_aws-secret-manager-secrets-name) | Name of AWS Secret manager secret with user list in json | `string` | `"mysql-users"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Specify AWS region for deployment | `string` | `"eu-west-1"` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds, must be between 0 and 259200 (72 hours) | `number` | `172800` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | Daily backup window time | `string` | `"03:00-05:00"` | no |
| <a name="input_cidr_blocks_for_public"></a> [cidr\_blocks\_for\_public](#input\_cidr\_blocks\_for\_public) | A list of subnets to allow FROM access to rds | `list(string)` | <pre>[<br>  "91.193.125.11/32",<br>  "91.193.126.216/32",<br>  "46.37.195.48/32"<br>]</pre> | no |
| <a name="input_cluster_family"></a> [cluster\_family](#input\_cluster\_family) | The family of the DB cluster parameter group | `string` | `"aurora-mysql5.7"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name. Live blank for autogenerate | `string` | `""` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | List of DB cluster parameters to apply | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_scaling_mode"></a> [cluster\_scaling\_mode](#input\_cluster\_scaling\_mode) | Enable Cluster autoscaling | `bool` | `false` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of database instances in the cluster | `number` | `1` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name to create as default | `string` | `"main"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port | `number` | `3306` | no |
| <a name="input_default_character_set"></a> [default\_character\_set](#input\_default\_character\_set) | The default\_character\_set of the database. | `string` | `"utf8"` | no |
| <a name="input_default_collation"></a> [default\_collation](#input\_default\_collation) | The default\_collation of the database. | `string` | `"utf8_general_ci"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Provide short service or application description. | `string` | `"Aurora cluster with users and privileges in databases"` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery | `list(string)` | <pre>[<br>  "audit",<br>  "error",<br>  "general",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `"aurora-mysql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless` | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version number of the database engine to use | `string` | `"5.7.mysql_aurora.2.07.1"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Provide valid environment abbreviation, ie.: tst, dev, qa, beta, staging | `string` | `"tst"` | no |
| <a name="input_iam_authentication_enabled"></a> [iam\_authentication\_enabled](#input\_iam\_authentication\_enabled) | iam\_authentication\_enabled require supported RDS Instance type. db.t2.small and db.t3.small not supported. More https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html | `bool` | `true` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | Iam roles for the Aurora cluster | `list(string)` | `[]` | no |
| <a name="input_instance_parameters"></a> [instance\_parameters](#input\_instance\_parameters) | List of DB instance parameters to apply | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | RDS Instance type | `string` | `"db.t2.medium"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN for the KMS encryption key | `string` | `""` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Weekly maintenance window | `string` | `"wed:02:00-wed:03:00"` | no |
| <a name="input_new-databases"></a> [new-databases](#input\_new-databases) | List of new databases to create. Leave blank if not required | `list(any)` | <pre>[<br>  "demo1",<br>  "demo2"<br>]</pre> | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Whether to enable Performance Insights | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data | `string` | `""` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Enable public access | `bool` | `true` | no |
| <a name="input_rds_monitoring_interval"></a> [rds\_monitoring\_interval](#input\_rds\_monitoring\_interval) | Interval in seconds to collect metrics (0, 1, 5, 10, 15, 30, 60) | `number` | `0` | no |
| <a name="input_rds_monitoring_role_arn"></a> [rds\_monitoring\_role\_arn](#input\_rds\_monitoring\_role\_arn) | The ARN for the IAM role that can send monitoring metrics to CloudWatch Logs | `string` | `""` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this is Read Replica | `string` | `""` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Number of days to retain backups for rds | `number` | `15` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles list | `list(any)` | <pre>[<br>  "dev",<br>  "qa"<br>]</pre> | no |
| <a name="input_roles_priv"></a> [roles\_priv](#input\_roles\_priv) | Template for privileges. Mapping user and privileges provided in 'users' variable | `map(any)` | <pre>{<br>  "dev": [<br>    "SELECT",<br>    "INSERT",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE",<br>    "DROP",<br>    "RELOAD",<br>    "PROCESS",<br>    "REFERENCES",<br>    "INDEX",<br>    "ALTER",<br>    "SHOW DATABASES",<br>    "CREATE TEMPORARY TABLES",<br>    "LOCK TABLES",<br>    "EXECUTE",<br>    "REPLICATION SLAVE",<br>    "REPLICATION CLIENT",<br>    "CREATE VIEW",<br>    "SHOW VIEW",<br>    "CREATE ROUTINE",<br>    "ALTER ROUTINE",<br>    "EVENT",<br>    "TRIGGER",<br>    "LOAD FROM S3",<br>    "SELECT INTO S3"<br>  ],<br>  "qa": [<br>    "SELECT",<br>    "EXECUTE",<br>    "UPDATE",<br>    "DELETE",<br>    "CREATE"<br>  ]<br>}</pre> | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | List of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless` | <pre>list(object({<br>    auto_pause               = bool<br>    max_capacity             = number<br>    min_capacity             = number<br>    seconds_until_auto_pause = number<br>    timeout_action           = string<br>  }))</pre> | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot | `string` | `""` | no |
| <a name="input_sport_prefix"></a> [sport\_prefix](#input\_sport\_prefix) | Provide valid sport prefix, ie.: AF, FB, BB, VLB, BSB, RPE | `string` | `"BSB"` | no |
| <a name="input_standard_cluster"></a> [standard\_cluster](#input\_standard\_cluster) | Non Serverless RDS Cluster | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the RDS cluster storage is encrypted | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Provide additional tags if if needed. | `map(string)` | <pre>{<br>  "name": "demo-rds"<br>}</pre> | no |
| <a name="input_use-aws-secret-userlist"></a> [use-aws-secret-userlist](#input\_use-aws-secret-userlist) | Create users from AWS Secret manager ? | `bool` | `false` | no |
| <a name="input_use-local-userlist"></a> [use-local-userlist](#input\_use-local-userlist) | Create users from list in variable ? | `bool` | `true` | no |
| <a name="input_use-users-with-auth-plugin"></a> [use-users-with-auth-plugin](#input\_use-users-with-auth-plugin) | Create users with plugin authentication? | `bool` | `true` | no |
| <a name="input_user_hosts"></a> [user\_hosts](#input\_user\_hosts) | list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable | `map(any)` | <pre>{<br>  "%": "%",<br>  "any": "%",<br>  "dev": "10.10.0.0/255.255.0.0",<br>  "localhost": "localhost",<br>  "vpn": "10.50.0.0/255.255.0.0"<br>}</pre> | no |
| <a name="input_users"></a> [users](#input\_users) | Provide users list | <pre>list(object({<br>    username = string<br>    host     = string<br>    role     = string<br>    password = string<br>    database = list(string)<br><br>  }))</pre> | <pre>[<br>  {<br>    "database": [<br>      "*"<br>    ],<br>    "host": "vpn",<br>    "password": "12345678",<br>    "role": "qa",<br>    "username": "user1"<br>  },<br>  {<br>    "database": [<br>      "*"<br>    ],<br>    "host": "%",<br>    "password": "12345678",<br>    "role": "qa",<br>    "username": "user2"<br>  }<br>]</pre> | no |
| <a name="input_users-with-auth-plugin"></a> [users-with-auth-plugin](#input\_users-with-auth-plugin) | Provide users list to create | <pre>list(object({<br>    username    = string<br>    host        = string<br>    role        = string<br>    auth_plugin = string<br>    database    = list(string)<br><br>  }))</pre> | <pre>[<br>  {<br>    "auth_plugin": "AWSAuthenticationPlugin",<br>    "database": [<br>      "*"<br>    ],<br>    "host": "%",<br>    "role": "qa",<br>    "username": "user5"<br>  }<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name to be used on all the resources as identifier | `string` | `"demo-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Databases"></a> [Databases](#output\_Databases) | Databases |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Database admin password |
| <a name="output_admin_user"></a> [admin\_user](#output\_admin\_user) | Database admin username |
| <a name="output_arn"></a> [arn](#output\_arn) | RDS Cluster ARN |
| <a name="output_azs"></a> [azs](#output\_azs) | A list of availability zones specified as argument to this module |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | Cluster Identifier |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | The ID of the security group created by default on Default VPC creation |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The DNS address or endpoint of the RDS instance |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for AWS NAT Gateway |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | A read-only endpoint for the Aurora cluster |
| <a name="output_users"></a> [users](#output\_users) | List of users |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
