resource "aws_route53_record" "dns" {
  zone_id = data.aws_route53_zone.base.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_ipv6" {
  zone_id = data.aws_route53_zone.base.zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "sans_dns" {
  for_each = {
    for i in range(length([for zone in data.aws_route53_zone.sans : zone])) :
    i => {
      zone = [for zone in data.aws_route53_zone.sans : zone][i]
      name = local.sans_domain_names[i]
    }
  }

  zone_id = each.value.zone.zone_id
  name    = each.value.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "sans_dns_ipv6" {
  for_each = {
    for i in range(length([for zone in data.aws_route53_zone.sans : zone])) :
    i => {
      zone = [for zone in data.aws_route53_zone.sans : zone][i]
      name = local.sans_domain_names[i]
    }
  }

  zone_id = each.value.zone.zone_id
  name    = each.value.name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cf.domain_name
    zone_id                = aws_cloudfront_distribution.cf.hosted_zone_id
    evaluate_target_health = true
  }
}
