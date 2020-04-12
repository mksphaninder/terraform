#variables

# variable name
variable "iam_user_prefix" {
    type = string 
    # any, boolean, map, set, object, tuple are some types.
    default = "my_iam_user" # variable value
}

# Name of the cloud.
provider "aws" { 
    region = "us-east-1"
    version = "~>2.46" # specifying the plugin (aws) version should be atleast 2.4.6
}

resource "aws_iam_user" "my_iam_users" {
    count = 1
    name = "${var.iam_user_prefix}_${count.index}" # calling variable
}