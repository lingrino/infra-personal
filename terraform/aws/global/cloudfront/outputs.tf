output "access_identity_srlingren_com_arn" {
  value = "${ aws_cloudfront_origin_access_identity.access_identity_srlingren_com.iam_arn }"
}

output "distribution_churner_io_domain" {
  value = "${ aws_cloudfront_distribution.churner_io.domain_name }"
}

output "distribution_srlingren_com_domain" {
  value = "${ aws_cloudfront_distribution.srlingren_com.domain_name }"
}
