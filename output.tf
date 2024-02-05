# Output Public IP for public1c
output "public1c_ip" {
  value = aws_instance.example-ec2-c.public_ip
}

# Output Public IP for public1d
output "public1d_ip" {
  value = aws_instance.example-ec2-d.public_ip
}

# Output SSH command for public1c
output "ssh_command_1c" {
  value = "ssh -i ${var.key_name} admin@${aws_instance.example-ec2-c.public_ip}"
}

# Output SSH command for public1d
output "ssh_command_1d" {
  value = "ssh -i ${var.key_name} admin@${aws_instance.example-ec2-d.public_ip}"
}

# Output Key Name
output "var_key_name" {
  value = var.key_name
}

# Output ALB DNS name
output "alb_dnsname" {
  value = aws_lb.example_alb.dns_name
}
