module "zone_hoo_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "hoo.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=mXA2oi_ATtgTx1BqzRWOgswAVqXRoSK0LF1CSyoD3zg"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_hoo_dev" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_hoo_dev.zone_id }"
  domain      = "dev.hoo.dev"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_hoo_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.hoo.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
