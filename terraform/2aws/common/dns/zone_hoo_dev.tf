module "zone_hoo_dev" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "hoo.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=mXA2oi_ATtgTx1BqzRWOgswAVqXRoSK0LF1CSyoD3zg"

  tags = "${ var.tags }"
}
