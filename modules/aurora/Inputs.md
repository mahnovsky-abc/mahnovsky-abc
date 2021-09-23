## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.43 |
| <a name="provider_github"></a> [github](#provider\_github) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-aws-naming"></a> [terraform-aws-naming](#module\_terraform-aws-naming) | git@github.com:abcfinancial2/abc-tfmod-naming-convention.git | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_rds_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [github_ip_ranges.git](https://registry.terraform.io/providers/hashicorp/github/latest/docs/data-sources/ip_ranges) | data source |
| [http_http.my_current_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Artifacts"></a> [Artifacts](#input\_Artifacts) | Describe required artifacts. | `string` | `"artifact"` | no |
| <a name="input_Creator"></a> [Creator](#input\_Creator) | Provide creator name to identify resource owner. | `string` | n/a | yes |
| <a name="input_Repository"></a> [Repository](#input\_Repository) | Provide deployment repository. | `string` | `"https://github.com/abcfinancial2/abc-tfmod-mysql"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Database admin password | `string` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | Database admin username | `string` | n/a | yes |
| <a name="input_allow_access_from_github"></a> [allow\_access\_from\_github](#input\_allow\_access\_from\_github) | Add external IP github to SG for allow access | `bool` | `false` | no |
| <a name="input_application"></a> [application](#input\_application) | Provide application description, ie.: Stats-Engine | `string` | n/a | yes |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| <a name="input_autoscale_min_capacity"></a> [autoscale\_min\_capacity](#input\_autoscale\_min\_capacity) | Minimal Instance number | `number` | `1` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Specify AWS region for deployment | `string` | `"eu-west-1"` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds, must be between 0 and 259200 (72 hours) | `number` | `172800` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | Daily backup window time | `string` | `"03:00-05:00"` | no |
| <a name="input_cidr_blocks_for_public"></a> [cidr\_blocks\_for\_public](#input\_cidr\_blocks\_for\_public) | A list of subnets to allow FROM access to rds | `list(string)` | `[]` | no |
| <a name="input_cluster_family"></a> [cluster\_family](#input\_cluster\_family) | The family of the DB cluster parameter group | `string` | `"aurora-mysql5.7"` | no |
| <a name="input_cluster_parameters"></a> [cluster\_parameters](#input\_cluster\_parameters) | List of DB cluster parameters to apply | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_scaling_mode"></a> [cluster\_scaling\_mode](#input\_cluster\_scaling\_mode) | Enable Cluster autoscaling | `bool` | `true` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of database instances in the cluster | `number` | `2` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name to create as default | `string` | `"main"` | no |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port | `number` | `3306` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Provide short service or application description. | `string` | n/a | yes |
| <a name="input_enable_access_from_current_environment"></a> [enable\_access\_from\_current\_environment](#input\_enable\_access\_from\_current\_environment) | Add external IP current enviroment to SG for allow access | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | List of log types to export to cloudwatch. The following log types are supported: audit, error, general, slowquery | `list(string)` | <pre>[<br>  "audit",<br>  "error",<br>  "general",<br>  "slowquery"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Valid values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `"aurora-mysql"` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `parallelquery`, `provisioned`, `serverless` | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version number of the database engine to use | `string` | `"5.7.mysql_aurora.2.07.2"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Provide valid environment abbreviation, ie.: TST, CI, UAT, PROD, GEN | `string` | `"tst"` | no |
| <a name="input_iam_authentication_enabled"></a> [iam\_authentication\_enabled](#input\_iam\_authentication\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | Iam roles for the Aurora cluster | `list(string)` | `[]` | no |
| <a name="input_instance_parameters"></a> [instance\_parameters](#input\_instance\_parameters) | List of DB instance parameters to apply | <pre>list(object({<br>    apply_method = string<br>    name         = string<br>    value        = string<br>  }))</pre> | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | RDS Instance type | `string` | `"db.t2.small"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN for the KMS encryption key | `string` | `""` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Weekly maintenance window | `string` | `"wed:02:00-wed:03:00"` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | Whether to enable Performance Insights | `bool` | `false` | no |
| <a name="input_performance_insights_kms_key_id"></a> [performance\_insights\_kms\_key\_id](#input\_performance\_insights\_kms\_key\_id) | The ARN for the KMS key to encrypt Performance Insights data | `string` | `""` | no |
| <a name="input_private_accessible"></a> [private\_accessible](#input\_private\_accessible) | Enable private access from subnet range | `bool` | `false` | no |
| <a name="input_private_network_ids"></a> [private\_network\_ids](#input\_private\_network\_ids) | List of private networks to allow access | `list(string)` | `[]` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Enable public access | `bool` | `false` | no |
| <a name="input_publicly_network_ids"></a> [publicly\_network\_ids](#input\_publicly\_network\_ids) | List of public networks to allow access | `list(string)` | `[]` | no |
| <a name="input_rds_monitoring_interval"></a> [rds\_monitoring\_interval](#input\_rds\_monitoring\_interval) | Interval in seconds to collect metrics (0, 1, 5, 10, 15, 30, 60) | `number` | `0` | no |
| <a name="input_rds_monitoring_role_arn"></a> [rds\_monitoring\_role\_arn](#input\_rds\_monitoring\_role\_arn) | The ARN for the IAM role that can send monitoring metrics to CloudWatch Logs | `string` | `""` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this is Read Replica | `string` | `""` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | Number of days to retain backups for rds | `number` | `15` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | List of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless` | <pre>list(object({<br>    auto_pause               = bool<br>    max_capacity             = number<br>    min_capacity             = number<br>    seconds_until_auto_pause = number<br>    timeout_action           = string<br>  }))</pre> | `[]` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted | `bool` | `true` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot | `string` | `""` | no |
| <a name="input_sport_prefix"></a> [sport\_prefix](#input\_sport\_prefix) | Provide valid sport prefix, ie.: AF, FB, BB, VLB, BSB, RPE | `string` | n/a | yes |
| <a name="input_standard_cluster"></a> [standard\_cluster](#input\_standard\_cluster) | Non Serverless RDS Cluster | `bool` | `true` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the RDS cluster storage is encrypted | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Provide additional tags if if needed. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Provide VPC ID for RDS database | `string` | n/a | yes |
| <a name="input_vpc_rds_security_group_ids"></a> [vpc\_rds\_security\_group\_ids](#input\_vpc\_rds\_security\_group\_ids) | Specify existing SGs for VPC | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Database admin password |
| <a name="output_admin_user"></a> [admin\_user](#output\_admin\_user) | Database admin username |
| <a name="output_arn"></a> [arn](#output\_arn) | RDS Cluster ARN |
| <a name="output_cluster_identifier"></a> [cluster\_identifier](#output\_cluster\_identifier) | Cluster Identifier |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | Database name |
| <a name="output_default_instance_endpoint"></a> [default\_instance\_endpoint](#output\_default\_instance\_endpoint) | Endpoint of default instance |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The DNS address or endpoint of the RDS instance |
| <a name="output_engine"></a> [engine](#output\_engine) | Database name |
| <a name="output_engine_mode"></a> [engine\_mode](#output\_engine\_mode) | Database engine mode |
| <a name="output_engine_version"></a> [engine\_version](#output\_engine\_version) | Database engine version |
| <a name="output_port"></a> [port](#output\_port) | Database engine version |
| <a name="output_reader_endpoint"></a> [reader\_endpoint](#output\_reader\_endpoint) | A read-only endpoint for the Aurora cluster |
