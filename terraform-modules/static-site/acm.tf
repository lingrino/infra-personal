# This provider is a dummy provider just because the acm-certificate module
# requires that we pass an explicit provider
# provider "aws" {
#   alias  = "cert"
#   region = "us-east-1"
# }

module "cert" {
  source = "../acm-certificate//"

  domain_name = var.domain_name
  zone_name   = var.zone_name

  sans_domain_names_to_zone_names = var.sans_domain_names_to_zone_names

  tags = var.tags

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}
