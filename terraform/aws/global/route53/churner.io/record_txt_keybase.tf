resource "aws_route53_record" "txt_keybase" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "@"
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["keybase-site-verification=iJBc7_j6Q-OtfLmOYqAyPyU4sNTcaC-DCYZudw6-L8w"]
}
