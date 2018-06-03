resource "aws_acm_certificate" "cert_vaku_io" {
  domain_name       = "vaku.io"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.vaku.io",
  ]

  tags = "${ merge(
    map(
      "Name",
      "vaku_io"
    ),
    module.constants.tags_default )
  }"
}
