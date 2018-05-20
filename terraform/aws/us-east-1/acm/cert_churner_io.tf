resource "aws_acm_certificate" "cert_churner_io" {
  domain_name       = "churner.io"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.churner.io",
  ]

  tags = "${ merge(
    map(
      "Name",
      "churner_io"
    ),
    module.constants.tags_default )
  }"
}
