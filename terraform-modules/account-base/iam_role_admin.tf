data "aws_iam_policy_document" "arp_admin_users" {
  source_json = data.aws_iam_policy_document.arp_users.json
}

data "aws_iam_policy_document" "arp_admin_terraform_cloud" {
  source_json = data.aws_iam_policy_document.arp_terraform_cloud.json
}

data "aws_iam_policy_document" "arp_admin_final" {
  source_json = data.aws_iam_policy_document.arp_terraform_cloud.json
}

resource "aws_iam_role" "admin" {
  name               = "Admin"
  description        = "A role for full admin access to the account"
  assume_role_policy = data.aws_iam_policy_document.arp_admin_final.json

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
