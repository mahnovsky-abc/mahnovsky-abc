#Main file for managing supported Terraform versions
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    aws    = ">= 3.55.0"
    random = "~> 2.1"
    mysql = {
      source  = "winebarrel/mysql"
      version = "1.10.5"
    }
  }
}
