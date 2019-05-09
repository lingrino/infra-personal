resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {"Name" = "DO_NOT_USE"},
    {"description" = "do not use. default security group created by AWS in this VPC"},
    var.tags,
  )
}

resource "aws_security_group" "endpoints" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {"Name" = "${var.name_prefix}-aws-vpc-endpoints"},
    {"description" = "Allow all traffic from the VPC into the AWS VPC endpoints"},
    var.tags,
  )
}

resource "aws_security_group_rule" "endpoints_all" {
  type              = "ingress"
  security_group_id = aws_security_group.endpoints.id

  protocol         = "-1"
  from_port        = 0
  to_port          = 0
  cidr_blocks      = [aws_vpc.vpc.cidr_block]
  ipv6_cidr_blocks = [aws_vpc.vpc.ipv6_cidr_block]
}
