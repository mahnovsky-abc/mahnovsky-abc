
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
  default     = "10.20.0.0/22"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.20.2.0/24", "10.20.3.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.20.0.0/24", "10.20.1.0/24"]
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



variable "environment" {
  type        = string
  description = "Provide valid environment abbreviation, ie.: tst, dev, qa, beta, staging"
  default     = "tst"
  validation {
    condition = (
      var.environment == "dev" ||
      var.environment == "qa" ||
      var.environment == "regression" ||
      var.environment == "migration" ||
      var.environment == "loadtest" ||
      var.environment == "staging" ||
      var.environment == "beta" ||
      var.environment == "prod" ||
      var.environment == "tst"
    )

    error_message = "The environment name must be: dev, qa, regression, migration, loadtest, staging, beta, prod, tst."
  }
}


variable "description" {
  description = "Provide short service or application description."
  type        = string
  default     = "Aurora cluster with users and privileges in databases"
}

variable "Creator" {
  description = "Provide creator name to identify resource owner."
  type        = string
  default     = "Develover"
}

variable "Repository" {
  description = "Provide deployment repository."
  type        = string
  default     = "https://github.com/abcfinancial2/abc-tfmod-mysql"
}

variable "Artifacts" {
  description = "Describe required artifacts."
  type        = string
  default     = "artifact"
}

variable "application" {
  type        = string
  description = "Provide application description, ie.: Stats-Engine"
  default     = "test-app"
}
