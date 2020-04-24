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
  ami                    = data.aws_ami.aws_linux_2_latest.id # OS
  key_name               = var.key_pair                       # key-pair name
  instance_type          = var.cpu_type                       # H/W
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]

  for_each  = data.aws_subnet_ids.default_subnets.ids
  subnet_id = each.value # N/W inside vpc

  tags = {
    name : "http_servers_${each.value}"
  }

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

resource "aws_security_group" "elb_sg" {
  name   = "elb_sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_elb" "elb" {

  name            = "elb"
  subnets         = data.aws_subnet_ids.default_subnets.ids
  security_groups = [aws_security_group.elb_sg.id]
  instances       = values(aws_instance.http_server).*.id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

}
