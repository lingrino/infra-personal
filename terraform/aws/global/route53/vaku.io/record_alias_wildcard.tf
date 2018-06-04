resource "aws_route53_record" "alias_wildcard" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "*.${ var.bare_domain }."
  type    = "A"

  alias {
    name                   = "${ data.terraform_remote_state.cloudfront.distribution_vaku_io_domain }"
    zone_id                = "${ module.constants.hosted_zone_id_cloudfront }"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_wildcard_ipv6" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "*.${ var.bare_domain }."
  type    = "AAAA"

  alias {
    name                   = "${ data.terraform_remote_state.cloudfront.distribution_vaku_io_domain }"
    zone_id                = "${ module.constants.hosted_zone_id_cloudfront }"
    evaluate_target_health = false
  }
}
