output "distribution_id" {
  description = "The ID of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.cf.id
}
