module "zone_vaku_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "vaku.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=rErM6Ph75uLJbtGJuj6D9NsruOHOGWFRHh-5zFNc668"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_vaku_dev" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_vaku_dev.zone_id }"
  domain      = "dev.vaku.dev"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_vaku_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.vaku.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
