output "bucket_logs_name" {
  value = "${ aws_s3_bucket.bucket_logs.id }"
}

output "bucket_logs_domain" {
  value = "${ aws_s3_bucket.bucket_logs.bucket_domain_name }"
}

output "bucket_srlingren_com_arn" {
  value = "${ aws_s3_bucket.bucket_srlingren_com.arn }"
}

output "bucket_srlingren_com_domain" {
  value = "${ aws_s3_bucket.bucket_srlingren_com.bucket_domain_name }"
}
