resource "aws_route53_record" "dns" {
  count = length(local.dns_names)

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = local.dns_names[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_ipv6" {
  count = length(local.dns_names)

  zone_id = data.aws_route53_zone.zone[count.index].zone_id
  name    = local.dns_names[count.index]
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}
