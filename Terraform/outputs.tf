output "instance_id" {
  value = aws_instance.PIN_final.id
}

output "public_ip" {
  value       = aws_instance.PIN_final.public_ip
  description = "The public IP of the web server"
}

output "security_groups" {
  value = [aws_instance.PIN_final.vpc_security_group_ids]
}
