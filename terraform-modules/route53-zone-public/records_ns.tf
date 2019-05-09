resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain
  type    = "NS"
  ttl     = "3600"
  records = aws_route53_zone.zone.name_servers

  allow_overwrite = true
}
