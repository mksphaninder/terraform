output "http_server_security_group" {
  value = "aws_security_group.http_server_security_group"
}

output "ec2_instance_details" {
  value = "aws_instance.http_server"
}

output "aws_instance_dns" {
  value = values(aws_instance.http_server).*.id
}

output "aws_ami_name" {
  value = data.aws_ami.aws_linux_2_latest.id
}



