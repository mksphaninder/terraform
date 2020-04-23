variable "aws_key_pair" {
  default = "~/aws/aws_keys/default-ec2.pem"
}

variable "ami_owner" {
  default = ["amazon"]
}

variable "cpu_type" {
  default = "t2.micro"
}

variable "key_pair" {
  default = "default-ec2"
}
