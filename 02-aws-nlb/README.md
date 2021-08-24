# AWS NLB for Aviatrix PSF Gateway

This is the 2nd provisioning step after Aviatrix PSF Gateways are created.

Modify ```terraform.tfvars``` for port and protocol required.


```
$ terraform state list
data.aviatrix_gateway.psf_gw
data.aws_subnet.psf_subnet_1
data.aws_subnet.psf_subnet_2
data.terraform_remote_state.ingress_infra
aws_lb.psf_nlb
aws_lb_listener.psf_nlb_listener
aws_lb_target_group.psf_nlb_tg
aws_lb_target_group_attachment.psf_nlb_attachment_1
aws_lb_target_group_attachment.psf_nlb_attachment_2
```
