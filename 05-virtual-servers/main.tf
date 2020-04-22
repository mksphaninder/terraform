# Name of the cloud.
provider "aws" {
  region  = "us-east-1"
  version = "~>2.46" # specifying the plugin (aws) version should be atleast 2.4.6
}
# Security Group
# HTTP Server -> 80 TCP
# SSH -> 22 TCP
# CIDR -> ["0.0.0.0/0"]

resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
  vpc_id = "vpc-e749789d"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "http_server_sg"
  }
}
