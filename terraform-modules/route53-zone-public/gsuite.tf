resource "aws_route53_record" "mx_verification" {
  count = var.enable_gsuite ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = 3600
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "10 ALT3.ASPMX.L.GOOGLE.COM.",
    "10 ALT4.ASPMX.L.GOOGLE.COM.",
  ]
}

resource "aws_route53_record" "custom_urls" {
  for_each = var.enable_gsuite ? toset(["mail", "calendar", "drive"]) : []

  zone_id = aws_route53_zone.zone.zone_id
  name    = "${each.key}.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com"]
}
