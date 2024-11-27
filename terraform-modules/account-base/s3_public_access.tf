resource "aws_s3_account_public_access_block" "s3" {
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
}
