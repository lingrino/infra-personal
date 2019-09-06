resource "aws_iam_user" "srlingren_gmail_com" {
  name = "sean@lingrino.com"
  path = "/user/"

  force_destroy = true

  tags = merge(
    { "Name" = "sean@lingrino.com" },
    var.tags
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
