resource "aws_route53_record" "txt_keybase" {
  count = var.keybase_record_value != "" ? 1 : 0

  zone_id = aws_route53_zone.zone.zone_id
  name    = "_keybase"
  type    = "TXT"
  ttl     = 3600
  records = [var.keybase_record_value]
}
