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
