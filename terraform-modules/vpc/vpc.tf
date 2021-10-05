resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_classiclink             = false
  enable_classiclink_dns_support = false

  assign_generated_ipv6_cidr_block = true

  tags = merge(
    { "Name" = "${var.name_prefix}" },
    var.tags
  )
}
