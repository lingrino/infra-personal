resource "aws_route53_record" "txt_google_site_verification" {
  count = var.google_site_verification_value != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [var.google_site_verification_value]
}
