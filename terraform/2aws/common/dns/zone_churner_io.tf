module "zone_churner_io" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "churner.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=flLaCz4pXRjj3B4s0VLT6o9DpJXnD_FFSH7Gbjmau3c"

  tags = "${ var.tags }"
}
