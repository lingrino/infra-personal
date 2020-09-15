output "bucket_arn" {
  description = "The name of the s3 bucket that the distribution fronts"
  value       = aws_s3_bucket.s3.arn
}

output "bucket_name" {
  description = "The name of the s3 bucket that the distribution fronts"
  value       = aws_s3_bucket.s3.id
}

output "distribution_id" {
  description = "The ID of the created cloudfront distribution"
  value       = aws_cloudfront_distribution.cf.id
}

output "deployer_access_key_id" {
  description = "The AWS access key id that can deploy to the site"
  value       = aws_iam_access_key.deployer.id
}

output "deployer_secret_access_key" {
  description = "The AWS secrety access key that can deploy to the site"
  value       = aws_iam_access_key.deployer.secret
  sensitive   = true
}
