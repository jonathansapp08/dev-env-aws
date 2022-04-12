output "dev_ip" {
  value       = aws_instance.dev_node.public_ip
  description = "Public IP that you can ssh into"
}
