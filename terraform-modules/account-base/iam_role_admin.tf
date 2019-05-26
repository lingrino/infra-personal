resource "aws_iam_role" "admin" {
  name               = "Admin"
  description        = "A role for full admin access to the account"
  assume_role_policy = data.aws_iam_policy_document.arp_users.json

  max_session_duration = 43200

  tags = merge(
    { "Name" = "Admin" },
    { "description" = "A role for full admin access to the account" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "admin_administrator" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
