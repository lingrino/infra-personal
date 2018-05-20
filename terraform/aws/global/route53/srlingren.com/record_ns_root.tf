resource "aws_route53_record" "ns_root" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ var.bare_domain }."
  type    = "NS"
  ttl     = "${ module.constants.route53_default_ns_ttl }"
  records = ["${ aws_route53_zone.zone.name_servers }"]
}
