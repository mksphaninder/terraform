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
    name = "my_iam_user_abc"
}
# STATE
# DESIRED - KNOWN - ACTUAL
# Terraform is declarative.
