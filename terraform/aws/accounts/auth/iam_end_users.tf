resource "aws_iam_user" "srlingren_gmail_com" {
  name          = "srlingren@gmail.com"
  force_destroy = true

  tags = merge(
    {"Name" = "srlingren@gmail.com"},
    var.tags,
  )
}

resource "aws_iam_user_login_profile" "srlingren_gmail_com" {
  user = aws_iam_user.srlingren_gmail_com.name

  pgp_key                 = "keybase:lingrino"
  password_length         = 30
  password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}
