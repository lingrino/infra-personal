data "aws_caller_identity" "current" {
}

locals {
  dns_names = keys(var.dns_names_to_zone_names)

  # The idea behind this list is that if someone is hosting a site at *.example.com then it should
  # be available at ALL subdomains of example.com (barring other more-specific records). So we
  # replace a '*' with the word 'wildcard' followed by a random string, meaning if the site is
  # hosted for *.example.com we will create a health check for wildcard-7475048120.example.com. This
  # will work as intended except when the is a more specific wildcard-7475048120.example.com record,
  # which we just assume is rare enough that it's not worth worrying about.
  healthcheck_domains = split(",", replace(join(",", local.dns_names), "*", "wildcard-7475048120"),
  )
}

data "aws_route53_zone" "zone" {
  count = length(local.dns_names)
  name  = element(values(var.dns_names_to_zone_names), count.index)
}
