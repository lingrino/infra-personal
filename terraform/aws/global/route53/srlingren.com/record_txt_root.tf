resource "aws_route53_record" "txt_root" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ var.bare_domain }."
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["google-site-verification=hQbHYjjZ9cakdTTBoYtnm7vwIoQ2O0uEEK9DCQZzez0"]
}
