variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "controller_ip" {
  type    = string
  default = ""
}

variable "aws_account" {
  type    = string
  default = ""
}

variable "ingress_spoke_name" {
  type    = string
  default = "ingress"
}

variable "ingress_cidr" {
  type    = string
  default = "10.21.0.0/16"
}

variable "destination_spoke_name" {
  type    = string
  default = "dest1"
}

variable "destination_spoke_cidr" {
  type    = string
  default = "10.22.0.0/16"
}

variable "psf_gw_name" {
  type    = string
  default = "psf"
}

variable "psf_gw_size" {
  type    = string
  default = "t3.medium"
}

variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-2"
}

variable "az1" {
  description = "Concatenates with region to form az names. e.g. eu-central-1a. Only used for insane mode"
  type        = string
  default     = "a"
}

variable "az2" {
  description = "Concatenates with region to form az names. e.g. eu-central-1b. Only used for insane mode"
  type        = string
  default     = "b"
}

locals {
  cidrbits  = tonumber(split("/", var.ingress_cidr)[1])
  newbits   = 26 - local.cidrbits
  netnum    = pow(2, local.newbits)
  subnet    = cidrsubnet(var.ingress_cidr, local.newbits, local.netnum - 2)
  ha_subnet = cidrsubnet(var.ingress_cidr, local.newbits, local.netnum - 1)
}