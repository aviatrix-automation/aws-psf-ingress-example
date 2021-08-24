resource "aws_instance" "default" {
  ami                         = data.aws_ami.nginx.id # Bitnami Nginx AMI
  instance_type               = var.instance_size
  key_name                    = var.ssh_key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.pub_ip
  security_groups             = var.security_groups
  lifecycle {
    ignore_changes = [security_groups]
  }
  source_dest_check = var.source_dest_check
  tags = {
    Name                   = var.name
    Auto-StartStop-Enabled = "",
  }
}

resource "aws_eip" "default" {
  count             = var.eip ? 1 : 0
  instance          = aws_instance.default.id
  network_interface = aws_instance.default.primary_network_interface_id
  vpc               = true
}

resource "aws_network_interface" "default" {
  count             = var.eth1 ? 1 : 0
  subnet_id         = var.eth1_subnet_id
  security_groups   = var.security_groups
  source_dest_check = var.source_dest_check

  attachment {
    instance     = aws_instance.default.id
    device_index = 1
  }
}