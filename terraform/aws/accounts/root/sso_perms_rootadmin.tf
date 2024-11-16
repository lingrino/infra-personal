resource "aws_ssoadmin_permission_set" "root_admin" {
  instance_arn = local.instance_arn

  name             = "root-admin"
  session_duration = "PT12H"

  tags = {
    Name = "root-admin"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "root_admin" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.root_admin.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_account_assignment" "root_admin" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.root_admin.arn

  principal_type = "GROUP"
  principal_id   = data.aws_identitystore_group.admin.group_id

  target_type = "AWS_ACCOUNT"
  target_id   = data.aws_caller_identity.current.account_id
}
