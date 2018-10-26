resource "aws_route53_record" "txt_keybase" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "_keybase"
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["keybase-site-verification=8EUL92yKoed8HeJs4zrZiupbo_S4zZw1bxomxDnOHlQ"]
}
