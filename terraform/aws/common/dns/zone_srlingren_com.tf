module "zone_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "srlingren.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_srlingren_com.zone_id }"
  domain      = "dev.srlingren.com"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.srlingren.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
