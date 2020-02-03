data "aws_route53_zone" "wg" {
  count = var.zone_name == "" || var.domain_name == "" ? 0 : 1
  name  = var.zone_name
}

resource "aws_route53_record" "wg" {
  count   = var.zone_name == "" || var.domain_name == "" ? 0 : 1
  zone_id = data.aws_route53_zone.wg.0.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [aws_eip.wg.public_ip]
}
