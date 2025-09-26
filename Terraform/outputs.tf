output "controller_ip" {
  value = aws_instance.Ansible-Controller.public_ip
}

output "node_ips" {
  value = aws_instance.Ansible-Node[*].public_ip
}