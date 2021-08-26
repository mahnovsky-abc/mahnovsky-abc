
variable mysql-credentials {
  description = "Credential for access to MySQL cluster"
  type = map
  default = {
     endpoint = "localhost:3306"
     username = "root"
     password = ""
  }
} 

variable "create-database" {
    description = "Create new database ?"
    type = bool
    default = false

}

variable "new-db-name" {
   description = "New db name. Leave blank if not required"
   type = string
   default = ""

}


variable "user_hosts" {
  description = "list of hosts and networks allowed for users. Mapping user and host provided in 'users' variable"
  type = map
  default = {
    "localhost" = "localhost"
    "dev" = "10.10.0.0/255.255.0.0"
    "vpn" = "10.50.0.0/255.255.0.0"
    "any" = "%"
    "%" = "%"
    
  }

}

variable "roles" {
 description = "Roles list"
 type = list
 default = ["dev", "qa"]
}

variable "roles_priv" {
    description = "Template for privileges. Mapping user and privileges provided in 'users' variable"
    type = map
    default = {
        "dev" = ["SELECT", "INSERT", "UPDATE", "DELETE", "CREATE", "DROP", "RELOAD", "PROCESS", "REFERENCES", "INDEX", "ALTER", "SHOW DATABASES", "CREATE TEMPORARY TABLES",
                 "LOCK TABLES", "EXECUTE", "REPLICATION SLAVE", "REPLICATION CLIENT", "CREATE VIEW", "SHOW VIEW", "CREATE ROUTINE", "ALTER ROUTINE", "EVENT", "TRIGGER", "LOAD FROM S3", "SELECT INTO S3"]
        "qa" =  ["SELECT", "EXECUTE" , "UPDATE", "DELETE", "CREATE"]
    
    }


}


variable "use-local-userlist" {
    description = "Create users from list in variable ?"
    type = bool
    default = false

}

# local user list. host and role should be created upper
variable "users" {
  description = "Provide users list"
  type = list(object({
    username = string
    host = string
    role = string
    password = string
  }))
   default = [
    {
      username = "jdoe6"
      host = "vpn"
      role = "qa"
      password = "123456543"
    },
    {
      username = "jdoe5"
      host =  "%"
      role = "qa"
      password = "9518462"
    }
  ]
}


variable "use-aws-secret-userlist" {
    description = "Create users from AWS Secret manager ?"
    type = bool
    default = false

}

# Please make sure that user list in secret is in correct format: should be in json like local user list upper
variable "aws-secret-manager-secrets-name" {
   description = "Name of AWS Secret manager secret with user list in json"
   type = string
   default = "mysql-users"

}
