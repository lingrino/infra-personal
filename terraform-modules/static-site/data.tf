locals {
  dns_names = "${ keys(var.dns_names_to_zone_names) }"
}

data "aws_route53_zone" "zone" {
  count = "${ length( local.dns_names ) }"
  name  = "${ element(values(var.dns_names_to_zone_names), count.index) }"
}
