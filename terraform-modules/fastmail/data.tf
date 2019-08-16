locals {
  zone_name = var.zone_name != "" ? var.zone_name : var.domain_name
}

data "aws_route53_zone" "zone" {
  name = local.zone_name
}
