resource "aws_acm_certificate" "cert" {
  provider = aws.cert

  domain_name = local.dns_names[0]

  validation_method = "DNS"
  subject_alternative_names = slice(local.dns_names, 1, length(local.dns_names))

  tags = merge(
    {"Name" = replace(local.dns_names[0], "*", "star")},
    {"fqdn" = replace(local.dns_names[0], "*", "star")},
    {"sans" = replace(join(" / ", slice(local.dns_names, 1, length(local.dns_names))),"*","star",)},
    {"valid_domains" = replace(join(" / ", local.dns_names), "*", "star")},
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Note that we set `allow_overwrite` here because sometimes two domains will have the same record
# name/value and this is the easiest way to manage that. Alternatively we could de-duplicate the
# domain_validation_options from the certificate.
# For example, if you request a cert to be valid for both example.com AND *.example.com then ACM
# will ask for two different validations, but both validations will have the same name and value and
# you will really only need to create ONE record. You can either deduplicate the domain_validation
# list or you can use allow_overwrite which lets terraform think that both records exist
resource "aws_route53_record" "cert" {
  provider = aws.dns

  count           = length(local.dns_names)
  allow_overwrite = true

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[count.index]["resource_record_name"]
  type    = aws_acm_certificate.cert.domain_validation_options[count.index]["resource_record_type"]
  ttl     = 60
  records = [aws_acm_certificate.cert.domain_validation_options[count.index]["resource_record_value"]]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.cert

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.cert.*.fqdn

  lifecycle {
    create_before_destroy = true
  }
}
