data "aws_caller_identity" "current" {
}

locals {
  domain_names      = concat([var.domain_name], keys(var.sans_domain_names_to_zone_names))
  sans_domain_names = keys(var.sans_domain_names_to_zone_names)

  # The idea behind this list is that if someone is hosting a site at
  # *.example.com then it should be available at ALL subdomains of example.com
  # (barring other more-specific records). So we replace a '*' with the word
  # 'wildcard' followed by a hash of the domain, meaning if the site is hosted
  # for *.example.com we will create a health check for
  # wildcard-hash.example.com. This will work as intended except when the is a
  # more specific wildcard-hash.example.com record, which we just assume is rare
  # enough that it's not worth worrying about.
  healthcheck_domains = var.healthcheck_domains_enabled ? [
    for domain in local.domain_names :
    replace(domain, "*", format("wildcard-%s", md5(domain)))
  ] : []
}

data "aws_route53_zone" "base" {
  name = var.zone_name
}

data "aws_route53_zone" "sans" {
  count = length(local.sans_domain_names)
  name  = values(var.sans_domain_names_to_zone_names)[count.index]
}
