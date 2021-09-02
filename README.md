# Terraform MySQL module

This repository contains Terraform module for MySQL users and privileges management.

## Features

* Central users management
* Database creation
* Manage users from local variable file
* Manage users from AWS Secret manager
* Manage user privileges based on prepared map

## Learn

This repository is enhanced with [pre-commit](https://pre-commit.com/) development framework which launches on every
commit. All required tooling to work with this repository can be installed using Makefile on Linux and MacOS user
machines. It is assumes that some core components on user machine have a default configuration, ie.: .profile and
user PATH variables for GoLang as an example.

Run below commands:

```
make all
pre-commit run --all-files
```


## Repository folder
* *examples* - working examples
* *modules* - folder with MySQL Module

Use winebarrel MySQL [provider](https://registry.terraform.io/providers/winebarrel/mysql/1.10.5)

## Usage
- clone repository
- cd  examples/manage-mysql
- provide valid endpoint and credentials for RDS MySQL cluster
- edit valid user list in variable or AWS Secret manager. In AWS Secret manager valid users format is:

```
[
  {
    "username": "user1",
    "password": "pass1",
    "host": "any",
    "role": "qa"
  },
  {
    "username": "user2",
    "password": "pass2",
    "host": "vpn",
    "role": "dev"
  }
]
```
- run terraform init
- run terraform plan to check planned actions and states
- run terraform apply to apply changes