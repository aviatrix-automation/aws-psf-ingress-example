resource "aws_lb" "psf_nlb" {
  name               = "avx-psf-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets = [data.terraform_remote_state.ingress_infra.outputs.spoke_aws_1.vpc.public_subnets[0].subnet_id,
  data.terraform_remote_state.ingress_infra.outputs.spoke_aws_1.vpc.public_subnets[1].subnet_id]
  enable_deletion_protection = false # Set to true for Prod
}

resource "aws_lb_target_group" "psf_nlb_tg" {
  name        = "avx-psf-nlb-tg"
  port        = var.psf_nlb_port
  protocol    = var.psf_nlb_protocol
  target_type = "ip"
  vpc_id      = data.terraform_remote_state.ingress_infra.outputs.spoke_aws_1.vpc.vpc_id
}

resource "aws_lb_listener" "psf_nlb_listener" {
  load_balancer_arn = aws_lb.psf_nlb.arn
  port              = var.psf_nlb_port
  protocol          = var.psf_nlb_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.psf_nlb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "psf_nlb_attachment_1" {
  target_group_arn  = aws_lb_target_group.psf_nlb_tg.arn
  target_id         = module.webserver1.private_ip
  availability_zone = "all"
  port              = var.psf_nlb_port
}

resource "aws_lb_target_group_attachment" "psf_nlb_attachment_2" {
  target_group_arn  = aws_lb_target_group.psf_nlb_tg.arn
  target_id         = module.webserver2.private_ip
  availability_zone = "all"
  port              = var.psf_nlb_port
}

module "web_server_sg" {
  source      = "terraform-aws-modules/security-group/aws//modules/http-80"
  name        = "web-server"
  description = "Security group for web-server with HTTP port open"
  vpc_id      = data.terraform_remote_state.ingress_infra.outputs.spoke_aws_2.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "webserver1" {
  source          = "./bitnami-nginx"
  name            = "psf-nginx-web1"
  subnet_id       = data.terraform_remote_state.ingress_infra.outputs.spoke_aws_2.vpc.private_subnets[0].subnet_id
  ssh_key_name    = var.aws_key_name
  security_groups = [module.web_server_sg.security_group_id]
}

module "webserver2" {
  source          = "./bitnami-nginx"
  name            = "psf-nginx-web2"
  subnet_id       = data.terraform_remote_state.ingress_infra.outputs.spoke_aws_2.vpc.private_subnets[1].subnet_id
  ssh_key_name    = var.aws_key_name
  security_groups = [module.web_server_sg.security_group_id]
}