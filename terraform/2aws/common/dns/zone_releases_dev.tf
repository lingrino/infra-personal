module "zone_releases_dev" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "releases.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=w-mW3rAl2RZMzV4VYbRWzmvUZIJIYQFr3SdTncrXFtI"

  tags = "${ var.tags }"
}
