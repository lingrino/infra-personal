resource "aws_acm_certificate" "cert_srlingren_com" {
  domain_name       = "srlingren.com"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.srlingren.com",
  ]

  tags = "${ merge(
    map(
      "Name",
      "srlingren_com"
    ),
    module.constants.tags_default )
  }"
}
