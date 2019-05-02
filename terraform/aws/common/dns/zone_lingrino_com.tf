module "zone_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"

  tags = "${ var.tags }"
}
