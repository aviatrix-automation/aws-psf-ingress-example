# Module AWS Bitnami Nginx Test Instance

This module deploys a Bitnami Nginx test instance in AWS

The following variables are required:

key | value
--- | ---
name | Name of the Ubuntu instance
subnet_id | Subnet ID in which the host will be launched
ssh_key | Key to insert into Ubuntu machine
security_groups | List of security groups to apply to instance

The following variables are optional:

key | default | value
--- | --- | ---
nginx_image | bitnami-nginx-1.21.1-4-r70-linux-debian-10-x86_64-hvm-ebs-nami | string to search for Nginx image
instance_size | t2.micro | nginx instance size
pub_ip | false | Set to true to enable public IP allocation
user_data | | provide user_data to bootstrap instance
source_dest_check | true | set false to disable source/dest checking
eip | false | assigns an EIP hen set to true.
eth1 | false | enable extra nic
eth1_subnet_id | | Subnet ID for eth1