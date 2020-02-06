resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name = data.aws_region.current.name == "us-east-1" ? "ec2.internal" : "${data.aws_region.current.name}.compute.internal"

  domain_name_servers = [
    cidrhost(aws_vpc.vpc, 2),
    "1.1.1.1",
  ]

  tags = merge(
    { "Name" = "${var.name_prefix}_dhcp_options" },
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
