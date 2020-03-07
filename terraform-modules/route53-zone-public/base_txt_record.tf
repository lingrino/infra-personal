# This file manages the base TXT record values, which are used by multiple services

resource "aws_route53_record" "txt_base" {
  count = var.enable_fastmail || var.google_site_verifications != [] ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = concat(var.google_site_verifications, [
    "v=spf1 include:spf.messagingengine.com ?all"
  ])
}
