variable "aws_key_pair" {
  default = "~/aws/aws_keys/default-ec2.pem"
}

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
  vpc_id = aws_default_vpc.default.id

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

resource "aws_instance" "http_server" {
  ami                    = "ami-0323c3dd2da7fb37d" # OS
  key_name               = "default-ec2"           # key-pair name
  instance_type          = "t2.micro"              # H/W
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = tolist(data.aws_subnet_ids.default_subnets.ids)[0] # N/W inside vpc

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)

  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                # install apache server
      "sudo service httpd start",                                                                                 # start the server
      "echo Welcome krishna -virtual server ip address is ${self.public_dns} | sudo tee /var/www/html/index.html" # copy a file
    ]
  }

}

resource "aws_default_vpc" "default" {

}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id
}

