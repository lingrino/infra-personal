resource "aws_cloudfront_distribution" "churner_io" {
  enabled             = true
  comment             = "Distribution fronting churner.io"
  price_class         = "PriceClass_100"                   # US, Canada, Europe
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  http_version        = "http2"

  aliases = [
    "churner.io",
    "www.churner.io",
  ]

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = "${ data.terraform_remote_state.acm_us_east_1.cert_churner_io_arn }"
  }

  logging_config {
    bucket          = "${ data.terraform_remote_state.s3.bucket_logs_domain }"
    prefix          = "cloudfront/churner_io/"
    include_cookies = false
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = "churner_io"

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
    origin_id   = "churner_io"
    domain_name = "churner-io.herokuapp.com"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "churner_io"
    ),
    module.constants.tags_default )
  }"
}
