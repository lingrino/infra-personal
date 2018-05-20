resource "aws_cloudfront_origin_access_identity" "access_identity_srlingren_com" {
  comment = "Access identity for the srlingren_com distribution"
}

resource "aws_cloudfront_distribution" "srlingren_com" {
  enabled             = true
  comment             = "Distribution fronting srlingren.com"
  price_class         = "PriceClass_All"
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  http_version        = "http2"

  aliases = [
    "srlingren.com",
    "*.srlingren.com",
  ]

  custom_error_response {
    error_code         = 404
    response_code      = "200"
    response_page_path = "/index.html"
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
    acm_certificate_arn      = "${ data.terraform_remote_state.acm_us_east_1.cert_srlingren_com_arn }"
  }

  logging_config {
    bucket          = "${ data.terraform_remote_state.s3.bucket_logs_domain }"
    prefix          = "cloudfront/srlingren_com/"
    include_cookies = false
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_cache_behavior {
    target_origin_id = "srlingren_com"

    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    min_ttl     = 0
    default_ttl = 31536000 # one year
    max_ttl     = 31536000 # one year

    forwarded_values {
      headers      = []
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  origin {
    origin_id   = "srlingren_com"
    domain_name = "${ data.terraform_remote_state.s3.bucket_srlingren_com_domain }"

    s3_origin_config {
      origin_access_identity = "${ aws_cloudfront_origin_access_identity.access_identity_srlingren_com.cloudfront_access_identity_path }"
    }
  }

  tags = "${ merge(
    map(
      "Name",
      "srlingren_com"
    ),
    module.constants.tags_default )
  }"
}
