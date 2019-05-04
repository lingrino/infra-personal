resource "aws_route53_record" "delegation" {
  zone_id = "${ var.zone_id }"
  name    = "${ var.domain }"
  type    = "NS"
  ttl     = 3600
  records = ["${ var.nameservers }"]
}
