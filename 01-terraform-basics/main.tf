# Name of the cloud.
provider "aws" { 
    region = "us-east-1"
    version = "~>2.45" # specifying the plugin (aws) version should be atleast 2.4.6
}

# The resource that should be created.
# syntax: `resource "type" "name"`
# Here we are creating the s3 bucket in AWS so the type is "aws_s3_bucket".
# Name is the internal name that is given in terraform.
# ---
# 2 step 
#   plan (terraform plan)
#   execute (terraform apply)
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-krishna-007" # Name of the bucket (Should be globally unique)
    versioning {
        enabled = true
    }
}

resource "aws_iam_user" "my_iam_user" {
    name = "my_iam_user"
}
# STATE
# DESIRED - KNOWN - ACTUAL
# Terraform is declarative.

# Output
output "my_s3_bucket_complete_details" {
    value = aws_s3_bucket.my_s3_bucket
}

output "my_iam_user" {
  value = aws_iam_user.my_iam_user
}
