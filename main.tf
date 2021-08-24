// AWS PSF Ingress Pattern
module "transit_aws_1" {
  source  = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version = "v4.0.1"
  cidr    = "10.1.0.0/20"
  region  = var.region
  account = var.aws_account
}

module "spoke_aws_1" {
  source     = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version    = "4.0.3"
  name       = var.ingress_spoke_name
  cidr       = var.ingress_cidr
  region     = var.region
  account    = var.aws_account
  transit_gw = module.transit_aws_1.transit_gateway.gw_name
}

module "spoke_aws_2" {
  source     = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version    = "4.0.3"
  name       = var.destination_spoke_name
  cidr       = var.destination_spoke_cidr
  region     = var.region
  account    = var.aws_account
  transit_gw = module.transit_aws_1.transit_gateway.gw_name
}

data "aws_route_table" "spoke_pub_rt1" {
  subnet_id = module.spoke_aws_1.vpc.public_subnets[0].subnet_id
}

data "aws_route_table" "spoke_pub_rt2" {
  subnet_id = module.spoke_aws_1.vpc.public_subnets[1].subnet_id
}

# PSF Gateway with HA
resource "aviatrix_gateway" "avx_psf_gateway_aws" {
  cloud_type                                  = 1
  account_name                                = var.aws_account
  gw_name                                     = var.psf_gw_name
  vpc_id                                      = module.spoke_aws_1.vpc.vpc_id
  vpc_reg                                     = var.region
  gw_size                                     = var.psf_gw_size
  subnet                                      = local.subnet
  zone                                        = "${var.region}${var.az1}"
  enable_public_subnet_filtering              = true
  public_subnet_filtering_route_tables        = [data.aws_route_table.spoke_pub_rt1.route_table_id]
  peering_ha_gw_size                          = var.psf_gw_size
  peering_ha_subnet                           = local.ha_subnet
  peering_ha_zone                             = "${var.region}${var.az2}"
  public_subnet_filtering_ha_route_tables     = [data.aws_route_table.spoke_pub_rt2.route_table_id]
  public_subnet_filtering_guard_duty_enforced = true
  single_az_ha                                = true
  enable_encrypt_volume                       = true
}