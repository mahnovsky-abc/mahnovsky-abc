
variable "aws_region" {
  type        = string
  default     = "eu-west-1"
  description = "Specify AWS region for deployment"
}
variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "demo-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_port" {
  type        = number
  default     = 3306
  description = "Database port"
}

variable "tags" {
  description = "Provide additional tags if if needed."
  type        = map(string)
  default     = { "name" : "demo-rds" }
}
