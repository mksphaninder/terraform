# Name of the cloud.
provider "aws" { 
    region = "us-east-1"
    version = "~>2.45" # specifying the plugin (aws) version should be atleast 2.4.6
}

resource "aws_s3_bucket" "my_tf_state" {
  bucket = "dev-tf-state-2794" # cannot use _
  
  lifecycle {
      prevent_destroy = true
  }

  versioning {
      enabled = true
  }

  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
  }
}

resource "aws_dynamodb_table" "dev_tf_lock" {

    name = "dev_application_locks"
    billing_mode = "PAY_PER_REQUEST"

    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
  
}
