module "zone_srlingren_com" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "srlingren.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"

  tags = "${ var.tags }"
}
