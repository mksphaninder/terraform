output "http_server_security_group" {
  value = "aws_security_group.http_server_security_group"
}

output "ec2_instance_details" {
  value = "aws_instance.http_server"
}

output "aws_instance_dns" {
  value = "aws_instance.http_server.public_dns"
}


