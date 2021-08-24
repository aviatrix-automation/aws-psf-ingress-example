variable "name" {
  type = string
}

variable "nginx_image" {
  type    = string
  default = "bitnami-nginx-1.21.1-4-r70-linux-debian-10-x86_64-hvm-ebs-nami"
}

variable "subnet_id" {
  type = string
}

variable "eth1_subnet_id" {
  type    = string
  default = ""
}

variable "ssh_key_name" {
  type = string
}

variable "security_groups" {
}

variable "instance_size" {
  type    = string
  default = "t2.micro"
}

variable "pub_ip" {
  type    = bool
  default = false
}

variable "eip" {
  type    = bool
  default = false
}

variable "eth1" {
  type    = bool
  default = false
}

variable "user_data" {
  default = ""
}

variable "source_dest_check" {
  type    = bool
  default = true
}