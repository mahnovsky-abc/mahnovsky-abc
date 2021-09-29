variable "new-databases" {
  description = "List of new databases to create. Leave blank if not required"
  type        = list(any)
  default     = []

}

variable "default_character_set" {
  description = "The default_character_set of the database."
  type        = string
  default     = ""

}
variable "default_collation" {
  description = "The default_collation of the database."
  type        = string
  default     = ""

}


variable "user_hosts" {
  description = "list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable"
  type        = map(any)
  default = {
    "localhost" = "localhost"
    "dev"       = "10.10.0.0/255.255.0.0"
    "vpn"       = "10.50.0.0/255.255.0.0"
    "any"       = "%"
    "%"         = "%"

  }

}

variable "roles" {
  description = "Roles list"
  type        = list(any)
  default     = ["dev", "qa"]
}

variable "roles_priv" {
  description = "Template for privileges. Mapping user and privileges provided in 'users' variable"
  type        = map(any)
  default = {
    "dev" = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "DROP", "RELOAD", "PROCESS", "REFERENCES", "INDEX", "ALTER", "SHOW DATABASES", "CREATE TEMPORARY TABLES",
    "LOCK TABLES", "EXECUTE", "REPLICATION SLAVE", "REPLICATION CLIENT", "CREATE VIEW", "SHOW VIEW", "CREATE ROUTINE", "ALTER ROUTINE", "EVENT", "TRIGGER", "LOAD FROM S3", "SELECT INTO S3"]
    "qa" = ["SELECT", "EXECUTE", "UPDATE", "DELETE", "CREATE"]

  }


}


variable "use-local-userlist" {
  description = "Create users from list in variable ?"
  type        = bool
  default     = false

}

# local user list. host and role should be created upper
variable "users" {
  description = "Provide users list to create"
  type = list(object({
    username = string
    host     = string
    role     = string
    password = string
    database = list(string)
  }))
  default = [
    {
      username = "user1"
      host     = "vpn"
      role     = "qa"
      password = "123456543"
      database = ["*"]
    },
    {
      username = "user2"
      host     = "%"
      role     = "qa"
      password = "9518462"
      database = ["*"]
    }
  ]
}

variable "use-users-with-auth-plugin" {
  description = "Create users with plugin authentication?"
  type        = bool
  default     = false
}

# user list with plugin auth. host and role should be created upper
variable "users-with-auth-plugin" {
  description = "Provide users list to create"
  type = list(object({
    username    = string
    host        = string
    role        = string
    auth_plugin = string
    database    = list(string)
  }))
  default = [
    {
      username    = "user3"
      host        = "%"
      role        = "qa"
      auth_plugin = "AWSAuthenticationPlugin"
      database    = ["*"]
    }
  ]

  validation {
    condition = alltrue([for s in var.users-with-auth-plugin : s.auth_plugin == "AWSAuthenticationPlugin" || s.auth_plugin == "mysql_no_login"]

    )
    error_message = "Allowed values: AWSAuthenticationPlugin or  mysql_no_login."
  }

}


variable "use-aws-secret-userlist" {
  description = "Create users from AWS Secret manager ?"
  type        = bool
  default     = true

}

# Please make sure that user list in secret is in correct format: should be in json like local user list upper
variable "aws-secret-manager-secrets-name" {
  description = "Name of AWS Secret manager secret with user list in json"
  type        = string
  default     = ""

}


variable "tls" {
  description = "An TLS-Option for the CREATE USER or ALTER USER statement. Ignored if MySQL version is under 5.7.0"
  type        = string
  default     = ""
  validation {
    condition = (
      var.tls == "NONE" ||
      var.tls == "SSL" ||
      var.tls == "X509" ||
      var.tls == "" # will be used from locals


    )
    error_message = "Allowed values for tls: NONE, SSL or  X509."
  }

}
