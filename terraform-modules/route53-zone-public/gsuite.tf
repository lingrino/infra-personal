resource "aws_route53_record" "mx_gsuite_verification" {
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

resource "aws_route53_record" "cname_gsuite_custom_urls" {
  for_each = var.enable_gsuite ? toset(["mail", "calendar", "drive"]) : []

  zone_id = aws_route53_zone.zone.zone_id
  name    = "${each.key}.${var.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["ghs.googlehosted.com"]
}

resource "aws_route53_record" "txt_gsuite_dkim" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = 3600

  # https://aws.amazon.com/premiumsupport/knowledge-center/route53-resolve-dkim-text-record-error/
  # The max length for a TXT record is 255. In route53 you can have a longer record by chaining text
  # together. Pieces will be chained together into a single longer record if you chunk the record
  # into 255 character pieces and wrap each piece in quotes without line breaks.
  records = [
    join("\"\"", [
      for i in range(0, ceil(length(var.gsuite_dkim_value) / 255) * 255, 255) :
      format("%s", substr(var.gsuite_dkim_value, i, 255))
    ])
  ]
}

resource "aws_route53_record" "txt_gsuite_dmarc" {
  count = var.gsuite_dkim_value != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; pct=100; rua=mailto:sean+dmarc@lingrino.com"]
}
