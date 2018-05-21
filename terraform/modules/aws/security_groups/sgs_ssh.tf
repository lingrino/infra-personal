resource "aws_security_group" "sg_in_ssh_from_all" {
  name_prefix            = "sg_in_ssh_from_all_"
  vpc_id                 = "${ var.vpc_id }"
  revoke_rules_on_delete = true

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "ssh"
  }

  tags = "${ merge(
    map(
      "Name",
      "sg_in_ssh_from_all",
      "description",
      "allow inbound on port 22 (ssh) from anywhere",
    ),
    var.tags,
    module.constants.tags_default )
  }"
}
