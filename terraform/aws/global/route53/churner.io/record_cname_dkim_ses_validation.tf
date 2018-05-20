resource "aws_route53_record" "dkim_ses_validation" {
  count   = "${ length( data.terraform_remote_state.ses_us_east_1.domain_churner_io_dkim_tokens ) }"
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "${ data.terraform_remote_state.ses_us_east_1.domain_churner_io_dkim_tokens[count.index] }._domainkey.${ var.bare_domain }."
  type    = "CNAME"
  ttl     = "${ module.constants.route53_default_cname_ttl }"
  records = ["${ data.terraform_remote_state.ses_us_east_1.domain_churner_io_dkim_tokens[count.index] }.dkim.amazonses.com"]
}
