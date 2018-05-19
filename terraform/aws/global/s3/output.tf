output "bucket_logs_name" {
  value = "${ aws_s3_bucket.bucket_logs.id }"
}
