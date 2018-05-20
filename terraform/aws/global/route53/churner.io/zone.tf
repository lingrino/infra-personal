resource "aws_route53_zone" "zone" {
  name    = "${ var.bare_domain }."
  comment = "Zone for ${ var.bare_domain }"

  force_destroy = true

  tags = "${ merge(
    map(
      "Name",
      "${ var.bare_domain }"
    ),
    module.constants.tags_default )
  }"
}
