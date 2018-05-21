resource "aws_security_group" "sg_in_http_https_from_all" {
  name_prefix            = "sg_in_http_https_from_all_"
  vpc_id                 = "${ var.vpc_id }"
  revoke_rules_on_delete = true

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "http"
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = "https"
  }

  tags = "${ merge(
    map(
      "Name",
      "sg_in_http_https_from_all",
      "description",
      "allow all inbound traffic on ports 80 and 443, http(s)",
    ),
    var.tags,
    module.constants.tags_default )
  }"
}
