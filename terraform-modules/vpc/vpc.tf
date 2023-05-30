resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = true

  tags = merge(
    { "Name" = "${var.name_prefix}" },
    var.tags
  )
}
