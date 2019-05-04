module "zone_releases_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "releases.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=w-mW3rAl2RZMzV4VYbRWzmvUZIJIYQFr3SdTncrXFtI"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_releases_dev" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_releases_dev.zone_id }"
  domain      = "dev.releases.dev"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_releases_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.releases.dev"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}
