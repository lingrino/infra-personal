module "zone_vaku_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=MCj8gnnw6xQz-RfOHNZuDY-oXMqOFTKcnjuOZFmSnQA"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_vaku_io" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_vaku_io.zone_id }"
  domain      = "dev.vaku.io"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_vaku_io" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.vaku.io"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
