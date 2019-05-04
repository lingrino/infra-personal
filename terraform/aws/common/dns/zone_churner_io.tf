module "zone_churner_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "churner.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=flLaCz4pXRjj3B4s0VLT6o9DpJXnD_FFSH7Gbjmau3c"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_churner_io" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_churner_io.zone_id }"
  domain      = "dev.churner.io"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_churner_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.churner.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
