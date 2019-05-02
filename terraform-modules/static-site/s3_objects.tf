resource "aws_s3_bucket_object" "index_html" {
  bucket                 = "${ aws_s3_bucket.s3.id }"
  key                    = "index.html"
  content_type           = "text/html"
  content_base64         = "${ base64encode( file( "${ path.module }/files/index.html" ) ) }"
  server_side_encryption = "AES256"
}
