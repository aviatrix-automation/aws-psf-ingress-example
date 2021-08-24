data "aws_ami" "nginx" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.nginx_image]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["979382823631"] # Bitnami Nginx
}