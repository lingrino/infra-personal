output "name" {
  description = "bucket name"
  value       = aws_s3_bucket.s3.bucket
}

output "arn" {
  description = "bucket arn"
  value       = aws_s3_bucket.s3.arn
}

output "domain" {
  description = "bucket domain"
  value       = aws_s3_bucket.s3.bucket_domain_name
}
