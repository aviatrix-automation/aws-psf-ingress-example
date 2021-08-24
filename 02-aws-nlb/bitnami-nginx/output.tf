output "aws_instance" {
  value = aws_instance.default
}

output "public_ip" {
  value = var.eip ? aws_eip.default[0].public_ip : aws_instance.default.public_ip
}

output "private_ip" {
  value = aws_instance.default.private_ip
}

output "eth1_id" {
  value = var.eth1 ? aws_network_interface.default[0].id : ""
}
