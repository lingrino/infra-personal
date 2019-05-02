module "zone_lingrino_dev" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "lingrino.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"

  tags = "${ var.tags }"
}
