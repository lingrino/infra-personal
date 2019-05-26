resource "aws_cloudfront_origin_access_identity" "ai" {
  comment = "Access identity for the ${var.name_prefix} distribution"
}

resource "aws_cloudfront_distribution" "cf" {
  enabled = true
  comment = "Distribution for ${var.name_prefix}: ${join(",", local.dns_names)}"

  http_version        = "http2"
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100" # USA, Canada, & Europe (Cheapest)

  aliases = local.dns_names

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = module.cert.certificate_arn
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = var.name_prefix

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
    origin_id = var.name_prefix
    # domain_name = heroku_app.app.heroku_hostname
    domain_name = var.heroku_app_domain # TODO switch to above when heroku provider supported

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  logging_config {
    include_cookies = false
    bucket          = var.bucket_logs_domain
    prefix          = "${data.aws_caller_identity.current.account_id}/${var.name_prefix}/"
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags
  )
}
