module "zone_policies_dev" {
  source = "../../../modules/aws/route53-zone-public//"

  domain            = "policies.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino.id }"

  keybase_record_value = "keybase-site-verification=qTSL6zK44D8LrYsZtmAuONv78iQa24l-pLDPhLW0oJo"

  tags = "${ var.tags }"
}
