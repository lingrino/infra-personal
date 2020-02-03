# The list of domain names to validate
locals {
  sans = keys(var.sans_domain_names_to_zone_names)

  // example.com and *.example.com will have the same validation records
  // here we make a list removing the *. domains if there's also a base domain
  // This list lets us know the count of validation records before we apply
  distinct_domain_names = distinct(concat([var.domain_name], [
    for domain_name in local.sans :
    replace(domain_name, "*.", "")
  ]))
}

resource "aws_acm_certificate" "cert" {
  provider = aws.cert

  domain_name = var.domain_name

  validation_method         = "DNS"
  subject_alternative_names = local.sans

  tags = merge(
    { "Name" = replace(var.domain_name, "*", "star") },
    { "fqdn" = replace(var.domain_name, "*", "star") },
    { "sans" = replace(join(" / ", local.sans), "*", "star", ) },
    { "valid_domains" = replace(join(" / ", concat([var.domain_name], local.sans)), "*", "star") },
    { "service" = "acm" },
    var.tags
  )

  lifecycle {
    create_before_destroy = true

    // We ignore changes here because AWS doesn't return these in the same order
    // that we create them and that can cause infinite loops of cert creation
    ignore_changes = [subject_alternative_names]
  }
}

locals {
  // Create a list of maps of validations to create certificates for, where we
  // again deduplicate against our earlier local for the *. domains
  validation_domains = [
    for domain, options in aws_acm_certificate.cert.domain_validation_options :
    tomap(options) if contains(local.distinct_domain_names, options.domain_name)
  ]
}

# Get zone ids for every domain validation record to create
data "aws_route53_zone" "zone" {
  provider = aws.dns

  count = length(local.distinct_domain_names)
  name  = element(local.validation_domains, count.index)["domain_name"]
}

resource "aws_route53_record" "cert" {
  provider = aws.dns

  count = length(local.distinct_domain_names)

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = element(local.validation_domains, count.index)["resource_record_name"]
  type    = element(local.validation_domains, count.index)["resource_record_type"]
  ttl     = 60
  records = [element(local.validation_domains, count.index)["resource_record_value"]]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.cert

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_acm_certificate.cert.domain_validation_options[*].resource_record_name

  depends_on = [aws_route53_record.cert]

  lifecycle {
    create_before_destroy = true
  }
}
