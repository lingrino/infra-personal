resource "aws_security_group" "sg_out_all" {
  name_prefix            = "sg_out_all_"
  vpc_id                 = "${ var.vpc_id }"
  revoke_rules_on_delete = true

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "all"
  }

  tags = "${ merge(
    map(
      "Name",
      "sg_out_all",
      "description",
      "allow all outbound traffic",
    ),
    var.tags,
    module.constants.tags_default )
  }"
}
