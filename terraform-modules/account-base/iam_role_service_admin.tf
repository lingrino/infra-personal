resource "aws_iam_role" "service_admin" {
  name        = "ServiceAdmin"
  description = "This role has full admin access to the account and should only be used by services"

  max_session_duration  = 7200
  assume_role_policy    = data.aws_iam_policy_document.arp_service.json
  force_detach_policies = true

  tags = merge(var.tags, {
    Name        = "ServiceAdmin"
    description = "This role has full admin access to the account and should only be used by services"
  })
}

resource "aws_iam_role_policy_attachment" "service_admin_administrator" {
  role       = aws_iam_role.service_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
