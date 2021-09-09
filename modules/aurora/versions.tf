#Main file for managing supported Terraform versions
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws    = ">= 3.43"
    random = "~> 2.1"
  }
}
