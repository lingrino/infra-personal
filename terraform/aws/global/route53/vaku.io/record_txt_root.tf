resource "aws_route53_record" "txt_root" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ var.bare_domain }."
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["google-site-verification=7WH10jjqiyuElcFEBFjl0qwA2Lvg_qOB8QA5DmeYLns"]
}
