#variables

variable "names" {
    default = ["tim","bob","krishna", "smith", "jane"]
}
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
    # count = length(var.names)
    # name = "${var.names[count.index]}" # calling variable
# best practise.
    for_each = toset(var.names)
    name = each.value
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
