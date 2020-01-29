resource "aws_iam_user" "sean_lingrino_com" {
  name = "sean@lingrino.com"
  path = "/user/"

  force_destroy = true

  tags = merge(
    { "Name" = "sean@lingrino.com" },
    var.tags
  )
}

resource "aws_iam_user_login_profile" "sean_lingrino_com" {
  user = aws_iam_user.sean_lingrino_com.name

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
