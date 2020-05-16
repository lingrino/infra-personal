resource "aws_security_group" "bastion" {
  name_prefix = "${var.name_prefix}-"
  vpc_id      = var.vpc_id

  tags = merge(
    { "Name" = var.name_prefix },
    { "description" = "security group for the bastion ec2 instance" },
    var.tags,
  )
}

resource "aws_security_group_rule" "bastion_in_cidrs" {
  type              = "ingress"
  security_group_id = aws_security_group.bastion.id

  protocol    = "-1"
  from_port   = 0
  to_port     = 0
  cidr_blocks = var.bastion_cidrs
}

resource "aws_security_group_rule" "bastion_out_all" {
  type              = "egress"
  security_group_id = aws_security_group.bastion.id

  protocol         = "-1"
  from_port        = 0
  to_port          = 0
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group" "bastion_inter" {
  name_prefix = "${var.name_prefix}-inter-"
  vpc_id      = var.vpc_id

  tags = merge(
    { "Name" = var.name_prefix },
    { "description" = "allow all in/out communication with the bastion instance" },
    var.tags,
  )
}

resource "aws_security_group_rule" "bastion_inter_in" {
  type              = "ingress"
  security_group_id = aws_security_group.bastion_inter.id

  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "bastion_inter_out" {
  type              = "egress"
  security_group_id = aws_security_group.bastion_inter.id

  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
  source_security_group_id = aws_security_group.bastion.id
}
