output "http_server_security_group" {
  value = "aws_security_group.http_server_security_group"
}

output "ec2_instance_details" {
  value = "aws_instance.http_server"
}

