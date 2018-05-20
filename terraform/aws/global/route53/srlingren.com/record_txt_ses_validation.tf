resource "aws_route53_record" "txt_ses_validation" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "_amazonses.${ var.bare_domain }."
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["${ data.terraform_remote_state.ses_us_east_1.domain_srlingren_com_verification_token }"]
}
