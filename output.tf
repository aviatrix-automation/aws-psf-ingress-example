output "transit_aws_1" {
  description = "Aviatrix Transit"
  value       = module.transit_aws_1
}

output "spoke_aws_1" {
  description = "Aviatrix Spoke"
  value       = module.spoke_aws_1
}

output "spoke_aws_2" {
  description = "Aviatrix Spoke"
  value       = module.spoke_aws_2
}

output "psf_gateway_aws" {
  description = "Public Subnet Filtering gateway"
  value       = aviatrix_gateway.avx_psf_gateway_aws
}