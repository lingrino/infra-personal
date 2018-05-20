resource "aws_route53_record" "mx_root" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ var.bare_domain }."
  type    = "MX"
  ttl     = "${ module.constants.route53_default_mx_ttl }"
  records = ["10 inbound-smtp.${ module.constants.aws_ses_region }.amazonaws.com"]
}
