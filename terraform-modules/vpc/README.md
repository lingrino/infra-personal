# Module - VPC

This module creates a standard and very opinionated VPC. The VPC is configured to use IPV6 and to
use a three-tiered subnet design. This module will also optionally create a VPN gateway for you and
VPC endpoints for **an opinionated set of** aws supported endpoint services (you can only create 20
per VPC).

## Usage

The below code is a simple way of calling the module.

```terraform
module "vpc" {
  source = "../path/to/module/terraform-modules/vpc//"

  name_prefix    = "vpc"
  vpc_cidr_block = "10.1.0.0/16"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]

  tags = var.tags
}
```

## Public vs Private vs Intra Subnets

In this module there are three types of subnets.

**Public Subnets** are assigned public IPs and are directly routable to the public internet.
Instances in these subnets will have a randomly assigned public IP. This is generally the subnet
where you launch AWS managed resources that will route to YOU Managed resources in private subnets.
For example, an Application Load Balancer that routes to EC2 targets in your private subnets.

**Private Subnets** are not routable *from* the internet, but they can *reach* the internet through
the configured NAT gateway. This is generally the subnet where you want to launch most of your
resources. Resources in this subnet can reach the internet for API calls and updates and such.

**Intra Subnets** have no route at all to the outside internet. They can only reach and be reached
by other internal infrastructure. This is a great place to put AWS managed data services such as
RDS, Redis, and Redshift.
