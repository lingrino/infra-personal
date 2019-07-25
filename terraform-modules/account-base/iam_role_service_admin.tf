resource "aws_iam_role" "service_admin" {
  name        = "ServiceAdmin"
  description = "This role has full admin access to the account and should only be used by services"
  path        = "/service/"

  max_session_duration = 7200
  assume_role_policy   = data.aws_iam_policy_document.arp_service.json

  tags = merge(
    { "Name" = "ServiceAdmin" },
    { "description" = "This role has full admin access to the account and should only be used by services" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "service_admin_administrator" {
  role       = aws_iam_role.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
