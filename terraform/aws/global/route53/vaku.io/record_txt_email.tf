resource "aws_route53_record" "txt_email" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ data.terraform_remote_state.ses_us_east_1.domain_vaku_io_mail_from_domain }"
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["v=spf1 include:amazonses.com ~all"]
}
