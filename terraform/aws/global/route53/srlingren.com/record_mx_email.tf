resource "aws_route53_record" "mx_email" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ data.terraform_remote_state.ses_us_east_1.domain_srlingren_com_mail_from_domain }"
  type    = "MX"
  ttl     = "${ module.constants.route53_default_mx_ttl }"
  records = ["10 feedback-smtp.${ module.constants.aws_ses_region }.amazonses.com"]
}
