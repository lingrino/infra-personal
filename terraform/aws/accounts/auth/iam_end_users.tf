resource "aws_iam_user" "sean_lingren_com" {
  name = "sean@lingren.com"
  path = "/user/"

  force_destroy = true

  tags = {
    Name = "sean@lingren.com"
  }
}

resource "aws_iam_user_login_profile" "sean_lingren_com" {
  user = aws_iam_user.sean_lingren_com.name

  password_length         = 30
  password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
    ]
  }
}
