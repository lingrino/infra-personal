resource "aws_iam_account_password_policy" "policy" {
  minimum_password_length   = 30
  max_password_age          = 90
  password_reuse_prevention = 24

  allow_users_to_change_password = true
  hard_expiry                    = false

  require_lowercase_characters = true
  require_numbers              = true
  require_uppercase_characters = true
  require_symbols              = true
}
