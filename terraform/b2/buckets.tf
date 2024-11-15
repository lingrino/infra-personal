resource "b2_bucket" "arq_mini" {
  bucket_name = "arq-mini"
  bucket_type = "allPrivate"

  file_lock_configuration {
    is_file_lock_enabled = true
  }
}
