variable "application_name" {
  default = "07-backend-state"
}

variable "project_name" {
  default = "users"
}

variable environment {
  default = "dev"
}

terraform {
  backend "s3" {
    bucket         = "dev-tf-state-2794"
    key            = "07-backend-state-dev-users"
    region         = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt        = true

  }
}

# Name of the cloud.
provider "aws" {
  region  = "us-east-1"
  version = "~>2.45" # specifying the plugin (aws) version should be atleast 2.4.6
}
