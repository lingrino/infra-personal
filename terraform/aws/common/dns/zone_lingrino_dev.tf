module "zone_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_lingrino_dev.zone_id }"
  domain      = "dev.lingrino.dev"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.lingrino.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
