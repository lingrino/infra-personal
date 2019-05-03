# This provider is a dummy provider just because the acm-certificate module
# requires that we pass an explicit provider
provider "aws" {
  alias  = "cert"
  region = "us-east-1"
}

module "cert" {
  source = "../acm-certificate//"

  dns_names_to_zone_names = "${ var.dns_names_to_zone_names }"

  tags = "${ var.tags }"

  providers {
    aws.dns  = "aws.cert"
    aws.cert = "aws.cert"
  }
}
