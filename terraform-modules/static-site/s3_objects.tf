resource "aws_s3_bucket_object" "index_html" {
  bucket                 = "${ aws_s3_bucket.s3.id }"
  key                    = "index.html"
  content_type           = "text/html"
  content_base64         = "${ base64encode( file( "${ path.module }/files/index.html" ) ) }"
  server_side_encryption = "AES256"

  lifecycle {
    ignore_changes = ["*"]
  }
}

resource "aws_s3_bucket_object" "robots_txt" {
  bucket                 = "${ aws_s3_bucket.s3.id }"
  key                    = "robots.txt"
  content_type           = "text/plain"
  content_base64         = "${ base64encode( file( "${ path.module }/files/robots.txt" ) ) }"
  server_side_encryption = "AES256"

  lifecycle {
    ignore_changes = ["*"]
  }
}

resource "aws_s3_bucket_object" "favicon_webp" {
  bucket                 = "${ aws_s3_bucket.s3.id }"
  key                    = "favicon.webp"
  content_type           = "image/webp"
  content_base64         = "${ base64encode( file( "${ path.module }/files/favicon.webp" ) ) }"
  server_side_encryption = "AES256"

  lifecycle {
    ignore_changes = ["*"]
  }
}
