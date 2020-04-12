#variables

variable "users" {
  default = {
    tim : { nick_name : "money", dept : "ABC" },
    bob : { nick_name : "bunny", dept : "REJ" },
    krishna : { nick_name : "sunny", dept : "JJJ" },
    smith : { nick_name : "Tony", dept : "SSS" },
    jane : { nick_name : "pony", dept : "LLL" }
  }
}
# variable name
variable "iam_user_prefix" {
  type = string
  # any, boolean, map, set, object, tuple are some types.
  default = "my_iam_user" # variable value
}

# Name of the cloud.
provider "aws" {
  region  = "us-east-1"
  version = "~>2.46" # specifying the plugin (aws) version should be atleast 2.4.6
}

resource "aws_iam_user" "my_iam_users" {

  for_each = var.users
  name     = each.key
  tags = {
    nick_name : each.value.nick_name
    department : each.value.dept
  }
}

# Some of the collection functions
# length(var.names)
# toset(var.names)
# distinct(var.names)
# concat(var.names, ["new_value"])
# contains(var.names, "ravi") -> false
# sort(var.names)
# range(10)-> [1,2,3...]
# range(1,12) -> [1,2,3..11]
