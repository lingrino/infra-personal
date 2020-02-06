resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.vpc.id

  subnet_ids = local.subnets

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no         = 101
    action          = "allow"
    protocol        = -1
    from_port       = 0
    to_port         = 0
    ipv6_cidr_block = "::/0"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no         = 101
    action          = "allow"
    protocol        = -1
    from_port       = 0
    to_port         = 0
    ipv6_cidr_block = "::/0"
  }

  tags = merge(
    { "Name" = "${var.name_prefix}_nacl" },
    var.tags
  )
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  tags = merge(
    { "Name" = "DO_NOT_USE" },
    { "description" = "do not use. default nacl options created by AWS in this VPC" },
    var.tags
  )
}
