resource "aws_security_group" "wg" {
  name_prefix = "${var.name_prefix}-"
  vpc_id      = var.vpc_id

  tags = merge(
    { "Name" = var.name_prefix },
    { "description" = "security group for the wireguard ec2 instance" },
    var.tags,
  )
}

resource "aws_security_group_rule" "wg_in_51820" {
  type              = "ingress"
  security_group_id = aws_security_group.wg.id

  protocol         = "udp"
  from_port        = 51820
  to_port          = 51820
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "wg_out_all" {
  type              = "egress"
  security_group_id = aws_security_group.wg.id

  protocol         = "-1"
  from_port        = 0
  to_port          = 0
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}
