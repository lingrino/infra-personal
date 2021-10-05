resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name = data.aws_region.current.name == "us-east-1" ? "ec2.internal" : "${data.aws_region.current.name}.compute.internal"

  domain_name_servers = [cidrhost(aws_vpc.vpc.cidr_block, 2)]

  tags = merge(
    { "Name" = "${var.name_prefix}" },
    var.tags
  )
}

resource "aws_vpc_dhcp_options_association" "dhcp" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
}

resource "aws_default_vpc_dhcp_options" "default" {
  tags = merge(
    { "Name" = "DO_NOT_USE" },
    { "description" = "do not use. default dhcp options created by AWS in this VPC" },
    var.tags
  )
}
