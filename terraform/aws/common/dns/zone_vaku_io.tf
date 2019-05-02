module "zone_vaku_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=MCj8gnnw6xQz-RfOHNZuDY-oXMqOFTKcnjuOZFmSnQA"

  tags = "${ var.tags }"
}
