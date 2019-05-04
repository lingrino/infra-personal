# Note that we do not use the static-site module here because churner is not a static site,
# although it has much of the same infrastructure as is created in the static-site module
module "cert_churner" {
  source = "../../../../terraform-modules/acm-certificate//"

  dns_names_to_zone_names {
    "churner.io"   = "churner.io"
    "*.churner.io" = "churner.io"
  }

  tags = "${ var.tags }"

  providers {
    aws.dns  = "aws"
    aws.cert = "aws"
  }
}

resource "aws_cloudfront_distribution" "churner" {
  enabled = true
  comment = "Distribution fronting churner.srlingren.com and churner.io"

  http_version    = "http2"
  is_ipv6_enabled = true
  price_class     = "PriceClass_100" # US, Canada, Europe

  aliases = [
    "churner.io",
  ]

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = "${ module.cert_churner.certificate_arn }"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = "churner"

    compress               = true
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 31536000 # one year
    max_ttl     = 31536000 # one year

    forwarded_values {
      headers      = ["*"]
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  origin {
    origin_id   = "churner"
    domain_name = "theoretical-dilophosaurus-y8ddbyi9nx2uo9haabxe5og8.herokudns.com" # From Heroku

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "${ data.terraform_remote_state.account_audit.bucket_logs_cloudfront_domain }"
    prefix          = "840856573771/churner/"
  }

  tags = "${ merge(
    map("Name", "churner"),
    var.tags )
  }"
}

resource "aws_route53_record" "churner_io" {
  zone_id = "Z1E0RVO5R5LL5G"
  name    = "churner.io"
  type    = "A"

  alias {
    name                   = "${ aws_cloudfront_distribution.churner.domain_name }"
    zone_id                = "${ aws_cloudfront_distribution.churner.hosted_zone_id }"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "churner_io_ipv6" {
  zone_id = "Z1E0RVO5R5LL5G"
  name    = "churner.io"
  type    = "AAAA"

  alias {
    name                   = "${ aws_cloudfront_distribution.churner.domain_name }"
    zone_id                = "${ aws_cloudfront_distribution.churner.hosted_zone_id }"
    evaluate_target_health = true
  }
}
