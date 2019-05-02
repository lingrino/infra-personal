module "zone_vaku_dev" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "vaku.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=rErM6Ph75uLJbtGJuj6D9NsruOHOGWFRHh-5zFNc668"

  tags = "${ var.tags }"
}
