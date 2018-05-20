resource "aws_route53_record" "acm_validation_us_east_1" {
  count   = "${ length( data.terraform_remote_state.acm_us_east_1.cert_srlingren_com_dns_validation ) }"
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  ttl     = "${ module.constants.route53_default_cname_ttl }"
  name    = "${ lookup( data.terraform_remote_state.acm_us_east_1.cert_srlingren_com_dns_validation[count.index], "resource_record_name" ) }"
  type    = "${ lookup( data.terraform_remote_state.acm_us_east_1.cert_srlingren_com_dns_validation[count.index], "resource_record_type" ) }"
  records = ["${ lookup( data.terraform_remote_state.acm_us_east_1.cert_srlingren_com_dns_validation[count.index], "resource_record_value" ) }"]
}
