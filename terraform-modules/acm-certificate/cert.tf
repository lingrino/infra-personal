# The list of DNS names to validate
locals {
  dns_names = keys(var.dns_names_to_zone_names)
}

resource "aws_acm_certificate" "cert" {
  provider = aws.cert

  domain_name = local.dns_names[0]

  validation_method         = "DNS"
  subject_alternative_names = slice(local.dns_names, 1, length(local.dns_names))

  tags = merge(
    { "Name" = replace(local.dns_names[0], "*", "star") },
    { "fqdn" = replace(local.dns_names[0], "*", "star") },
    { "sans" = replace(join(" / ", slice(local.dns_names, 1, length(local.dns_names))), "*", "star", ) },
    { "valid_domains" = replace(join(" / ", local.dns_names), "*", "star") },
    { "service" = "acm" },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Deduplicate because sometimes different DNS names need the same validation
# ex: 'example.com' & '*.example.com'
# This is essentially a way of deduplicating a list of maps based on a key in the maps
locals {
  domain_validation_options_dedup = {
    for option in aws_acm_certificate.cert.domain_validation_options :
    option.resource_record_name => option...
  }
  domain_validation_options = [
    for rrn, list_of_options in local.domain_validation_options_dedup :
    list_of_options[0]
  ]
}

# Get zone ids for every domain validation record to create
data "aws_route53_zone" "zone" {
  provider = aws.dns

  count = length(local.domain_validation_options)
  name  = var.dns_names_to_zone_names[local.domain_validation_options[count.index]["domain_name"]]
}

resource "aws_route53_record" "cert" {
  provider = aws.dns

  count = length(local.domain_validation_options)

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = local.domain_validation_options[count.index]["resource_record_name"]
  type    = local.domain_validation_options[count.index]["resource_record_type"]
  ttl     = 60
  records = [local.domain_validation_options[count.index]["resource_record_value"]]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.cert

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_acm_certificate.cert.domain_validation_options.*.resource_record_name

  depends_on = [aws_route53_record.cert]

  lifecycle {
    create_before_destroy = true
  }
}
